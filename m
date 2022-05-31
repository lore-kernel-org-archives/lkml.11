Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D73FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 20:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347723AbiEaU0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 16:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347720AbiEaUZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:25:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A399956FB8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Pi2zX9Fh1F2zwwd9lP/nv2QAiCHqPeUziLacnhOZdD4=; b=IRNliGkr/AD0ZcrTdMKn6G9E0L
        zdIeG585w1UAmMBIdQszzKiivEQLlj2nLyPsN1bsPRO8PtdIUnEDqt60+0xM9iwK+PT66aETliVEI
        QVf/TS7Mlb6T6zWOAfrKmERe2us4LxYCVD7qf0zoM2NdGBdkrgTbmzhvhXNcI4mR0Owfq0D3O+/dC
        Pg0bjaJrQSkTBCYifX55iIN2UWRX4kJ+SMRQ3h6btZQ6oIyALg3x2elRvntaY50TQHMqnSENninBh
        o2DVmPOdwogvYy0EwYezsJILSfQlT629JI7kQZ1KO8+52XwW4scAVvAzNb63PqnL2wQ3MZhExPHDe
        y49fff+w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nw8R9-005fl5-W5; Tue, 31 May 2022 20:25:56 +0000
Message-ID: <d136df0c-34fc-d21c-1353-fa82deb62975@infradead.org>
Date:   Tue, 31 May 2022 13:25:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Kconfig rules (depends, imply)
Content-Language: en-US
To:     Muni Sekhar <munisekharrms@gmail.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <CAHhAz+gUpxzukjde1rMqRcPre8yMROBd3yQTCm89wMGb2zWriw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHhAz+gUpxzukjde1rMqRcPre8yMROBd3yQTCm89wMGb2zWriw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 5/31/22 05:14, Muni Sekhar wrote:
> Hi all,
> 
> menuconfig SOUNDWIRE
>         tristate "SoundWire support"
>         depends on ACPI || OF
> 
> "depends on ACPI || OF" mean, SOUNDWIRE depends on both ACPI and OF modules?
> 

"||" is logical OR, so SOUNDWIRE depends on either ACPI or OF (or both
of them can be enabled).


> 
> config SOUNDWIRE_QCOM
>         tristate "Qualcomm SoundWire Master driver"
>         imply SLIMBUS
> 
> What does "imply SLIMBUS" mean?

See Documentation/kbuild/kconfig-language.rst:

- weak reverse dependencies: "imply" <symbol> ["if" <expr>]

  This is similar to "select" as it enforces a lower limit on another
  symbol except that the "implied" symbol's value may still be set to n
  from a direct dependency or with a visible prompt.

So (in your example) SLIMBUS is desired but not required.
That means that the code that is built for SOUNDWIRE_QCOM
probably needs to use IS_REACHABLE(CONFIG_SLIMBUS) to
see if that SLIMBUS code is available at build time.

HTH.
-- 
~Randy
