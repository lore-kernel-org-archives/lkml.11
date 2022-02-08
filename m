Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9D0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 14:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377247AbiBHOBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 09:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347474AbiBHOBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:01:42 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33574C03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:01:42 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id i62so21203846ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 06:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7aA6YF+GsgEfI0h+DNZiuAXZYvOtMmeC1bEBfF0tbw=;
        b=lpjihUxs/LmLJZ33gqGMbA3VCou+/PSb4KwyGXkB++Ms9L2DqtxrVa79cpzJ3hfe9u
         HQIz7pJ9UGNjucW7Dn8c4VEbj0hx4+UXmpD+CfJuNU/Ll0O+chhIei9Ylgp4tc1J2wFb
         k9uj0bWbqbzFPm9XvH4dBJBn9VRaizq2HWszlVPSofVKtjHdepecuQLjbWaJOYAPCNh0
         5+5DwS7xT331ITm2HeD+FBsov/PFPGrLiKO7Uwgc7gNI5cE/tl/OsFdkePlLq83kryY5
         e822pYaOeosVR6TIghB2omK7FpKptFy7ne1ozbP8TbehBqQo349bSiIo5fOtlCXzVx2R
         AgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7aA6YF+GsgEfI0h+DNZiuAXZYvOtMmeC1bEBfF0tbw=;
        b=rWh/MX19YK62sxrlbbb87bF9qt++L+uT1UBJYsXfNJQPbX7nyirRy8uothVfCuLJZs
         RhGj0jQqeDhbzDhtEH+f+EIFIelmlV6NIr9TvO4uyQmET79NPTUYxr1BWUzT5grY6SEq
         DFAo255fbk0Lv1xfv/f/s0UjS6uXFelToFcUUS0HLbm1wrbqT8b3VpVr+9DMRREiVFG1
         /ZnsN0q8zIrCkkclUiy/tX8zXZdVBngipwBSJz/nTrd398YD9l55lAnUOMBpvZt+wUf3
         YYPsbYHPCppqlXWnj7v3HtgZukYKO+76NXyX90fFzB2cpIMvYtkVqps82VLG1zidsqZv
         MUuw==
X-Gm-Message-State: AOAM530X2kI91yoEDwa/KnM+bX3jlw5TtvtOId8bkBXciEodsZVD0fn4
        4C8OJ24oJUsuJvgRA2KG11SonXLkp/h49cW87IM=
X-Google-Smtp-Source: ABdhPJwdoszuI/1eBvag/YJnxGMC5sTLZPFeC9SnKVBc4cRuk1U9R/iVujm95FCtxeRDuVzK/zkgUts6+odDPOwr8j8=
X-Received: by 2002:a05:6638:380f:: with SMTP id i15mr2181383jav.308.1644328901638;
 Tue, 08 Feb 2022 06:01:41 -0800 (PST)
MIME-Version: 1.0
References: <202202081303.QEI35DwC-lkp@intel.com>
In-Reply-To: <202202081303.QEI35DwC-lkp@intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 8 Feb 2022 15:01:30 +0100
Message-ID: <CANiq72=K0sH=PGdZY56U2KqhvBu2ww4rq1h_WcDrqFNnxaJWyg@mail.gmail.com>
Subject: Re: [ojeda-linux:ci 4/9] rust/helpers.c:39:17: warning: no previous
 declaration for 'rust_helper_BUG'
To:     kernel test robot <lkp@intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 6:20 AM kernel test robot <lkp@intel.com> wrote:
>
> >> rust/helpers.c:39:17: warning: no previous declaration for 'rust_helper_BUG' [-Wmissing-declarations]
>       39 | __noreturn void rust_helper_BUG(void)
>          |                 ^~~~~~~~~~~~~~~

Fixed on `rust` -- I will put it in `rust-next` soon.

Thanks a lot!

Cheers,
Miguel
