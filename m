Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83354C25B0F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Aug 2022 20:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbiHMUsJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Aug 2022 16:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiHMUsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 16:48:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A48B7F2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 13:48:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fy5so7403448ejc.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8+24X1voRXl29E4Men41L011ucEXlLL6AMGFCSV5598=;
        b=Dooj+Rt0Wkp9Ypz84bBRTewTk2pQT9Tu5y7qW759b9Mtrc3SZ43E8XcW9aDFFOK5sZ
         sF4ncAxPj/SMoklJ1LEW21Su6HnBf+T0tr0XRCgnIXeHdVcRorK+6j+8vKktCEjAGyPw
         TPAteKxOIBm4xNNwhUeBUFLI4vPswYFE376ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8+24X1voRXl29E4Men41L011ucEXlLL6AMGFCSV5598=;
        b=aBNAH36xzpoNm9t/6QDmtPUAzse1J+aUWInoDIXg27GmxN6z+Zh2LBVwNt7VHNxtbI
         yMrOrNG+vWcIlJPcnJbq71g6RXSi47jC6Qh4t6LCNwkf1AoAwFoVns0rNdBsWNxDuL4d
         aqx8KrF7JoCM8VXs749Vk5K8ABE75csP3n7BR7K7vumDRjhXhllMC4vrswCpjS2U+1B3
         7ShWR5Yl5u43mcOIVJyBhwXm5iZgVYNdfLEACHtFHqMrv3sCkelboPCpY1KQtyxAJyyG
         Ofxg97DGL9YtBIrRtu9o+PGSdPeYMFZSCzAA80s7SkYuhBZT5PV5EnRrGwOrKcMwudTh
         g7Gw==
X-Gm-Message-State: ACgBeo3MPignBtqDkwxCdFghpJU+H7QwMSUb+fdsHiOFbMApwZMsvLto
        k+HXxBhACkTZ5By1UXD9YhY4LAXvbosiV5dk
X-Google-Smtp-Source: AA6agR7x+3PetZgKkMKw7R38pEuEY7QcnyPSZYv0oBT2669JpWNuFPWsdgaXfryjdIa4nMNhPGaBVQ==
X-Received: by 2002:a17:907:868d:b0:730:f0ba:6328 with SMTP id qa13-20020a170907868d00b00730f0ba6328mr6379387ejc.444.1660423684521;
        Sat, 13 Aug 2022 13:48:04 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b00731582a6717sm2251709ejd.98.2022.08.13.13.48.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 13:48:04 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id l22so4688446wrz.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 13:48:03 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr4746439wri.442.1660423683645; Sat, 13
 Aug 2022 13:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <62ef6e3d028a5182f4485d6201a126bbf4ca659c.camel@HansenPartnership.com>
In-Reply-To: <62ef6e3d028a5182f4485d6201a126bbf4ca659c.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Aug 2022 13:47:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgeVWg=3sae6u__x2dhMzxw2-nyTTkxbQZfkDrueXGvTg@mail.gmail.com>
Message-ID: <CAHk-=wgeVWg=3sae6u__x2dhMzxw2-nyTTkxbQZfkDrueXGvTg@mail.gmail.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.19+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 5:55 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> [my key just expired so you'll need to do the dane update thing I
> showed you]

Oh, I don't care about expired keys at all. As long as you keep using
the *same* key, I'm happy, and gpg saying "Note: This key has
expired!" is something I'll happily ignore.

None of the technical rules of pgp keys make any sense at all. The
"sufficient trust" computations are completely pointless garbage with
the whole "marginal" vs "complete trust". It's all just crazy talk.

The expiry times likewise. I will completely ignore those.

I will check the signatures of a key as I import them. Because anybody
who thinks that "trust" is about automation is probably not human, or
so far on the spectrum that they don't understand humans.

              Linus
