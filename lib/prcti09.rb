require "prcti09/version"
require 'gcd.rb'


#####################################  MAtriz
class Matriz
  attr_accessor :m, :n
  def initialize (m,n)
	@m = m
	@n = n
  end
end
#####################################  MAtriz Densa
class Mdensa < Matriz
  attr_accessor :matriz
  def initialize (m,n)
	super(m,n)
	@matriz = Array.new(m){ Array.new(n) }
  end
  
  #insertar
  def []= (i,j,valor)
	@matriz[i][j] = valor
  end

  #mostrar
  def [] (i)
  	return @matriz[i]	
  end
  
  def +(other)
                resultado = Mdensa.new(@m,@n)
		i = 0
		j = 0 
                while i < @m
         		while j < @n
                                resultado[i][j] = @matriz[i][j] + other[i][j]
				j += 1
                        end
			j = 0
			i += 1
                end
                resultado
   end

   def -(other)
                resultado = Mdensa.new(@m,@n)
                i, j = 0 , 0
                while i < @m
                        while j < @n
                                resultado[i][j] = @matriz[i][j] - other[i][j]
                                j = j + 1
                        end
                j = 0
                i = i + 1
                end
                resultado
   end

        def *(other)
                resultado = Mdensa.new(@m,@n)
                
                i = 0
                j = 0
                k = 0
                while i < @m
                        while j < @n
                                while k< @n
                                        resultado[i][j] = @matriz[i][k] * other[k][j]
                                        k = k + 1
                                end
                                k = 0
                                       j = j + 1
                        end
                               j = 0
                        i = i + 1
                end
		resultado
        end

    def min
		min = @matriz[0][0]
                i, j = 0 , 0
                while i < @m-1
                        while j < @n-1
 				if @matriz[i][j] < min
		         		min = @matriz[i][i]
                                end
				j = j + 1
                        end
                j = 0
                i = i + 1
                end
                min
   end


    def max     
                max = 0
                i, j = 0 , 0
                while i < @m
                        while j < @n
                                if (@matriz[i][j] > max)
                                        max = @matriz[i][i]
                                end
                                j = j + 1
                        end
                j = 0
                i = i + 1
                end
                max
   end


end

#####################################  MAtriz Dispersa
 
class MDispersa < Matriz
  attr_accessor :v
  def initialize (m,n,v)
	super(m,n) 
	@v = v    
  end
 
  def []=(j)
  	@v[j]
  end

  def index(j,i)
	v = @v.fetch(j,0)
	if v!= 0
		v.fetch(i,0)
 
	else
		0	
	end
 end 

	def [](i)
            @v[i]
          end

  def to_s
	@v
  end

  def +(other)
	case other
	when Mdensa
		other.+(self)
	when MDispersa
		v = @v.merge(other.v){|key, v1, v2| v1.merge(v2){|key1, va2, va3| va2 + va3}}
		MDispersa.new(@m, other.n, v)
		
	end
  end

   def -(other)
	case other
	when Mdensa
		other.-(self)
	when MDispersa
		v = @v.merge(other.v){|key, v1, v2| v1.merge(v2){|key1, va2, va3| va2 - va3}}
		MDispersa.new(@m, other.n, v)
		
	end
   end


	
  def *(other)
                
  end

	   def max
                        aux = @v.keys
                        aux1 = aux[0]
                        aux2 = @v[aux1].values
                        mayor = aux2[0]
                        @v.each {
                                |key, va| va.each {
                                        |key2, va2|
                                        mayor = index(key,key2) if index(key,key2) > mayor
                                }
                        }
                        mayor
            end
            
	    def min
                        aux = @v.keys
                        aux1 = aux[0]
                        aux2 = @v[aux1].values
                        mayor = aux2[0]
                        @v.each {
                                |key, va| va.each {
                                        |key2, va2|
                                        mayor = index(key,key2) if index(key,key2) < mayor
                                }
                        }
                        mayor
             end

end


#####################################  Racional

class Racional

        include Comparable
   attr_accessor :numerador, :denominador

   def initialize(numerador, denominador)
      @numerador, @denominador = numerador, denominador
      # reducir
   end

   def reducir(rac)
      mcd = gcd(rac.numerador, rac.denominador)
      racional = Racional.new((rac.numerador/mcd),rac.denominador/mcd)
   end

   def num
      @numerador
   end

   def denom
      @denominador
   end

   def to_s
      "#{@numerador}/#{@denominador}"
   end

   def flotante
      @numerador/@denominador
   end

   def abs
      if @numerador < 0 then @numerador = @numerador * -1 end
      if @denominador < 0 then @denominador = @denominador * -1 end
   end

   def reciprocal
      a = @numerador
      @numerador = @denominador
      @denominador = a
   end

   def -@
      @numerador = @numerador * -1
   end

   def +(other)
      mcm = (@denominador * other.denominador)/gcd(@denominador, other.denominador)
      @racional = Racional.new(((mcm/@denominador*@numerador) + (mcm/other.denominador*other.numerador)),mcm)
      reducir(@racional)
   end

   def -(other)
      mcm = (@denominador * other.denominador)/gcd(@denominador, other.denominador)
      @racional = Racional.new(((mcm/@denominador*@numerador) - (mcm/other.denominador*other.numerador)),mcm)
      reducir(@racional)
   end

   def *(other)
      @racional = Racional.new((@numerador * other.numerador),@denominador * other.denominador)
      reducir(@racional)
   end

   def /(other)
           @racional = Racional.new((@numerador * other.denominador),@denominador * other.numerador)
      reducir(@racional)
   end

   def %(other)
      (@numerador/@denominador)%(other.numerador/other.denominador)
   end

   def <=>(other)
      mcm = (@denominador * other.denominador)/gcd(@denominador, other.denominador)
      a = (mcm/@denominador*@numerador)
      b = (mcm/other.denominador*other.numerador)

      if a < b
         -1
      elsif a > b
         1
      else
         0
      end
   end

   def coerce(other)
      if Integer === other
         [self, Racional.new(other,1)]
      else
         [other, self]
      end
   end
end


#####################################  Main

 @m = Mdensa.new(2,2)
 @m[0,0] = 1
 @m[0,1] = 2
 @m[1,0] = 3
 @m[1,1] = 4

 @m1 = Mdensa.new(2,2)
 @m1[0,0] = 1
 @m1[0,1] = 2
 @m1[1,0] = 3
 @m1[1,1] = 4
 
 @m3 = Mdensa.new(2,2)
 @m3 = @m +(@m1)
 puts @m3[0][0]
 puts @m3[0][1]
 puts @m3[1][0]
 puts @m3[1][1]

@m3 = @m -(@m1)
 puts @m3[0][0]
 puts @m3[0][1]
 puts @m3[1][0]
 puts @m3[1][1]
@m3 = @m *(@m1)
 puts @m3[0][0]
 puts @m3[0][1]
 puts @m3[1][0]
 puts @m3[1][1]

puts @m3.min
puts @m3.max














