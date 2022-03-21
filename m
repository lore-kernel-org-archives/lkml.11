Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CD0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 07:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbiCUH2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244518AbiCUH2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:28:14 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96DC2BD3;
        Mon, 21 Mar 2022 00:26:49 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id d7so19384385wrb.7;
        Mon, 21 Mar 2022 00:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=ENOqnP/WW6UM3qaFy0lGbYegzr0M5eqkdbS/cdjw0fo=;
        b=vIKwUXnWGf6j81kTfjIAWfNyPzwUSBKqoZMSpGmRsRYdnTMKpBqGA25yErtYCzTfha
         n0jbV/8a7CuzKc/jJaBBP23IZNYs/hboqdUzEOYmnqcgQ4rFkTZK7EvUHMlaSKAEvR01
         /OJfA36mOH/iWUHXMRWM8TadK3zK+J4TXmpohU3saAPSeTLoIkRHaUO7V0v8Xrrg0OL5
         mv+7Vra2cPrV2jrGikXIVUTGAdGuLIkggB/hMJXb0/e+wvPMpHTFXRXMZ1+sUXE9Axz1
         9leBaW0DhnUpnBsWNqDubt5zAicRr6O/KX74JUOCpYYwS938tYmsojzQqNnvHYxhiJBR
         WusQ==
X-Gm-Message-State: AOAM532SVgRaO3ffjjs/IrDvZGjewu4aVUbbyTp10UJDoBkFacOxH/VM
        risHUnQF+oxsoFi84+Uq9v5fgQQLt3E=
X-Google-Smtp-Source: ABdhPJzUvmAWRgR7q1ci7OIP+LVdN/znbcBcE8pa47RQfSIyM0lvTooRFU1rnpzwDTGkVK9wZXpO9w==
X-Received: by 2002:a5d:6c69:0:b0:203:78af:48b2 with SMTP id r9-20020a5d6c69000000b0020378af48b2mr16800440wrz.123.1647847608398;
        Mon, 21 Mar 2022 00:26:48 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm5330249wmq.27.2022.03.21.00.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:26:47 -0700 (PDT)
Message-ID: <dd4e55aa-0b3e-6e18-7ec2-3bec02cafde0@kernel.org>
Date:   Mon, 21 Mar 2022 08:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: hppa vDSO and compiler (non-)support
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
 <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
In-Reply-To: <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 03. 22, 6:48, Jiri Slaby wrote:
> Hi,
> 
> On 08. 03. 22, 15:51, Helge Deller wrote:
>> Hi Jiri,
>>
>> Thanks for testing on parisc!
>>
>> On 3/8/22 12:06, Jiri Slaby wrote:
>>> since the "parisc: Add vDSO support" commit, I can no longer 
>>> cross-build a hppa kernel. I see two issues:
>>>
>>> 1) CROSS32_COMPILE detection doesn't work here, as openSUSE provides 
>>> hppa-suse-linux-* binaries. It's easy to overcome by 
>>> "CROSS32_COMPILE=hppa-suse-linux-"
>>
>> How is it handled for other platforms like s390x?
> 
> s390 simply uses CC for vdso32:
> cmd_vdso32cc = $(CC) $(c_flags) -c -o $@ $<
> 
>> Would it make sense to add the detection for SUSE too?
> 
> Maybe.

So, could 1) be fixed on the Kconfig side? Or should I (people running 
SUSE) use "CROSS32_COMPILE=hppa-suse-linux-"?

>>> 2) openSUSE doesn't provide any libc for hppa. So gcc doesn't provide 
>>> libgcc.a and the build of vDSO fails.
>>
>> libgcc.a comes with the compiler, I don't think you need libc for that.
> 
> I was told glibc is needed to build libgcc.a.

2) was fixed on the compiler (SUSE) side. cross-hppa-gcc12-bootstrap was 
introduced -- note it's known to be a misnomer -- it should have been 
like s/-bootstrap/-baremetal/.

thanks,
-- 
js
suse labs
