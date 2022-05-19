Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2AFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 17:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbiESREB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiESREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:04:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F28B4C7A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:03:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j24so8120818wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xM5n/q+pdgADcY+P4WfPB73lVe6lU3/dOsh4SpBlyyM=;
        b=ddoNPFiwomNGnVYEj4t3in7WWD9an5zcNZoUuNwnQSZGdkZdI6acfqDb/hxJQJi9Hl
         xGJOb+wH0itT0oDcT3x4H9yMHh3AL8N3WKqOVAoOeZ8fqGjgl3Nd6W+6rxigSs4LO3im
         1pZRn0Cf4sTbyN5SIvQtHyQfivtftRPvgbob65+WKdX/GeB396nVVDvcDwrSg5Znp/YG
         4CzUU9B7YurMq2k151Q84zKSz26L55Wk0T4fJm5o50cwO+4WiAfxtkldssDw8a48eAM8
         y0usIHhIx1QRocuHNecPfPKL5KuMw0AtLEDopPtWpkbns+pRRCcFoSCDrAal5K0QDM6h
         kl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xM5n/q+pdgADcY+P4WfPB73lVe6lU3/dOsh4SpBlyyM=;
        b=DGL7GJF7v4y3r7G/7oAqC9oi9zQsVSu7sAzs6WDxGnLllY6Y0bnuI1vwOJRRor5PmY
         CeFDZ4F73f51X6N1gXlIN7dxUw5wMBF8UTk/xflASz+fXDsAA8CDK1EP7eXfFM55gxEX
         ch4zViO7bIPmccEJLreRzJyj2uCD3easMx25aqXu15L8iWmdi+Slwx+wz52O7EcdRDC8
         TbRdSSVOigF8v/jTnrmEeUw6Nui6E4BOwhzazxS6OIAIR02944E+OL9L7T7ho+Dn/bg+
         aCqvaD28ucBTJvhcPao84jh55pHTrBu+umBCZNNWMOEnRVNyzOePgh/UbqIU8znpRRmk
         bqGA==
X-Gm-Message-State: AOAM531Ut1MjKZr+p1vqOiIpCrQmZw0N9wpqfO1okh6bxtAWVFvTs0ct
        0k7+HCuM36ubVbE+cII9JDxb6f8m8tfRE2Yk
X-Google-Smtp-Source: ABdhPJwOb7/uDptoM2mZZlgWpb/vvJM+AQpDom8d8DP5QnBk3ta5cHEtKe6nD9CKlI49Y6wBfdH4Iw==
X-Received: by 2002:a05:6000:178d:b0:20c:5bfd:4d7d with SMTP id e13-20020a056000178d00b0020c5bfd4d7dmr4784229wrg.23.1652979837779;
        Thu, 19 May 2022 10:03:57 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id i17-20020a05600c355100b00394867d66ddsm31882wmq.35.2022.05.19.10.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 10:03:57 -0700 (PDT)
Message-ID: <5b219857-4fe9-2406-2c6f-0511e8c33765@linaro.org>
Date:   Thu, 19 May 2022 18:03:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] nvmem: brcm_nvram: check for allocation failure
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        stable@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220510093540.23259-1-srinivas.kandagatla@linaro.org>
 <YoZ2ozeju8bXzUyX@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YoZ2ozeju8bXzUyX@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/05/2022 17:56, Greg KH wrote:
> On Tue, May 10, 2022 at 10:35:40AM +0100, Srinivas Kandagatla wrote:
>> From: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> Check for if the kcalloc() fails.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 299dc152721f ("nvmem: brcm_nvram: parse NVRAM content into NVMEM cells")
> 
> This isn't a commit in any tree that I can see, are you sure it is
> correct?
Looks like the commit is not correct,
It should be

Fixes: 6e977eaa8280 ("nvmem: brcm_nvram: parse NVRAM content into NVMEM 
cells")


Dan, can you send this with fix to Fixes tag?

--srini


> 
> thanks,
> 
> greg k-h
