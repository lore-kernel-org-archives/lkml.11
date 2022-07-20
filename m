Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE814C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 11:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiGTLpV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 07:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiGTLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:45:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5A92AF3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:45:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o7so29794796lfq.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZDb/On6XpUXGe/BJm5NfUcWD+cnAuZMq9dvjIa0120Q=;
        b=mEZPxA1vR+xPG2zKAqSjMAl+Xfst+1s20IXxFWtE0YwU8WFkqkEXqZxhMzqIbE50sJ
         2HB8Guraupn6VExjrv4po+z9HItiF5Bhynj5e6fO/cMlM/mkW1T4MiWv1aM6hfiwIZCh
         A8SQUlwfZCOsZB0QpYHn60AolriwbJ2muruEyjpwNp7JeitooPKqfCrkLqfDs7Irfu/j
         230TztwbI4Gz7PGtNCUsH8Xi/SgF67hLw7oqwJnTzS0VNw3n98dgs3+LD1n7a0V+yLCa
         p5zBdwLcD0BZEckkBF6235jro3HnTCyLl5PrIo46bjUzDDM1tZ6YQIRaduGJMwEIF/ZP
         xlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZDb/On6XpUXGe/BJm5NfUcWD+cnAuZMq9dvjIa0120Q=;
        b=anJcLCYPEK+ErBxzo4JIuSFY+6bknuAn32JZvqcl6NM8cFwJkFnBAoxVDBkTKqdOVo
         6krnKx1WbLfPjV/Ooo/uhm1FAiNETDkcQTAGVM1MVWJ7dj2zEG+8s2QRh/1ubAhmgLrj
         KdhA0PAhueXY2cElJw4TVI3wUP/+QTtGB1a5KtdB2J2CfRyTpN8ihnCtWjSnwKkAD4cb
         NGKH0+MUUK9Ucd3TqX6P/ZvkIteuWW/5IrdP2pJVldzApEg/kknt/xSAk64pOZftk7TL
         FRPfFY8veLZhrL1oidWdVQv1EMsuKQJeBwdmbfGd7eJl3epedH/AjfOGXka9GfboiYKI
         ZU7g==
X-Gm-Message-State: AJIora++f2cjxKrCL7wnTVGXvlNbqDpNb9nl4QEVmiDz8KEzdtwkfm6H
        aVTqIlE7Sz7khRagFo2nByamCQ==
X-Google-Smtp-Source: AGRyM1soy5TCPoLRJYPdeSShcI/P9RSINYXDcAFMHV4+0MdfdZkNBveORV3fCWEyMFwt9APprxQurQ==
X-Received: by 2002:a05:6512:33c4:b0:489:da1c:76cc with SMTP id d4-20020a05651233c400b00489da1c76ccmr21016882lfg.237.1658317514235;
        Wed, 20 Jul 2022 04:45:14 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id t13-20020a056512208d00b00482bdd14fdfsm3800568lfr.32.2022.07.20.04.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 04:45:13 -0700 (PDT)
Message-ID: <6ab25b0a-8c34-696e-5d10-1ffb335d850b@linaro.org>
Date:   Wed, 20 Jul 2022 13:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: fpga: Fix typo in comment
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220720113704.18185-1-slark_xiao@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720113704.18185-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 13:37, Slark Xiao wrote:
> Fix typo in the comment
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 2 +-

Did you receive my feedback or something got lost on the way?

Best regards,
Krzysztof
