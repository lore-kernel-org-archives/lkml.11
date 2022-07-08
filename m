Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DE3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 19:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiGHTJT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbiGHTJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:09:18 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0EC1D30F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:09:17 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h5so13374365ili.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y1wllwkKXolSys4v3ung7uyvokJaDV7sWQpVsVaOyjM=;
        b=LGlvmEEQvIEfWGHTw8jRiK/N2KDzIGX+Wj0qmHVCRSg6kLWO9ug9JcPFxLaYvKFeEh
         tCvMvzZHqN3I4VaE2gw9egEiyCFSDPPthT7+RWCbQRmSkyDbwC2p9bBA8R/MautRsSPJ
         lOvTwX9Iw1ey1WkJWi+4CJrW1F7ftoHpMUcoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y1wllwkKXolSys4v3ung7uyvokJaDV7sWQpVsVaOyjM=;
        b=xivQ5UxKBhE4tfYk7sLZJ6sQ+FlwoIAQYhjqEbe5XzZgpW5fXFgxJtHXsXcKJlSPdo
         28ohkSnMvh0zpuaG/rwVWRsd7Ax+44On2FMWKcmLQofdc/r30+vpyuLdd2MXUd2bWPTc
         xcwYLU2mVTnfuWYGN+HhuglHXuXGKDA8KzehOlFZcVG4SycL5rRX6aDWTkvoY0maxYHz
         hPlG8YwGQ4qXe0bsapnfR5es+BHU7894Ij7G2a+82MpSBsquV1Wav9qeTYGH1jlxEfRv
         FdwvXhLP2uWUdErlEs3davXCO23IfxcuB3FjrMMlNoNDop4XlzNV1L4J8pMlPaEA8xqU
         9xMA==
X-Gm-Message-State: AJIora+eAS60a4APpH9IKB9CAqdnv3EGd+KOgWiq0BMFW9H7sueSt+iJ
        R6J/pXzChVAgjFRGFmTlMmnkQw==
X-Google-Smtp-Source: AGRyM1t0SChz311Ai5LSjJMld51OT+szPZHRlMmBZiu0PM9+3e6k2w1RhGithVxX98KOiH6AMpJACw==
X-Received: by 2002:a05:6e02:1a21:b0:2dc:4dab:c323 with SMTP id g1-20020a056e021a2100b002dc4dabc323mr2971715ile.62.1657307357104;
        Fri, 08 Jul 2022 12:09:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x11-20020a026f0b000000b0033e9c4c6a9esm8460775jab.82.2022.07.08.12.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 12:09:16 -0700 (PDT)
Subject: Re: PROBLEM: dmesg tracedumps on rtsx_usb module loading during boot
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QWxla3NhIFZ1xI1rb3ZpxIc=?= <aleksav013@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220708134942.r3nhwzgh4nchaebi@artix.localdomain>
 <Ysg20t2t/S11idyx@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0fc74c07-791e-a6f2-de43-510852a3517c@linuxfoundation.org>
Date:   Fri, 8 Jul 2022 13:09:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Ysg20t2t/S11idyx@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/22 7:53 AM, Greg Kroah-Hartman wrote:
> On Fri, Jul 08, 2022 at 03:49:42PM +0200, Aleksa Vučković wrote:
>> [1.] One line summary of the problem:
>> dmesg tracedumps on rtsx_usb module loading during boot
> 
> This should be fixed in linux-next now, right?
> 
> Shuah (on cc:) send in some commits to resolve this, look at this
> thread:
> 	https://lore.kernel.org/all/cover.1656642167.git.skhan@linuxfoundation.org/
> 
> If you could test those 2 patches, that would be great.
> 
> thanks,
> 
> greg k-h
> 

Yes. Please test these patches and send me the trace you are seeing
as well. It will help us confirm if it is the same problem or a new
one.

thanks,
-- Shuah
