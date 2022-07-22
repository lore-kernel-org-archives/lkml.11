Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58219C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 03:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiGVDlv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 23:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiGVDlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:41:47 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50922643F6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:41:46 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id m30so1584920vkl.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6t0IUBMGetr6oz3Y7sZFzLbHV2LZOrR7YXBxR8Udec=;
        b=qffvVkoXn1pWID1OAay+i4uZg8BnMz+bbjCNzLbruPss2asFkOanZctSCH+gDdb5N+
         TNrfh46FsuEZOEF33ta9zkM5PxWs4InugOcSDT3PJyfD01HHyvuNzkYHHRRslGv26g1X
         sYZXWRiozPhT8+gy6fqtaqkcV5bO3WUMilyN/nOpFVO+YO+gAxEHP1MGMvGCvsG5CYV4
         6tdEBMlVc+S/IQgdjqmFmsWXna8JCYd16/TtkGZkilPerQ+n2y48JPlepojrQK91Bt9W
         DHmt21KXfdtVuu7BlUBKR6lS+y4Qa3ydHddJYEiS4Exis6bmRg/tcXRRyQIAvg5MN9jC
         X//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6t0IUBMGetr6oz3Y7sZFzLbHV2LZOrR7YXBxR8Udec=;
        b=Nqadx68851Gnvq1uje5RjjvGtFaRDIBjJ2hlSxmPekoNh5w9Mc3ZG/ufHvNR3i1cLB
         esdhLI24fOzuym7+IFspJPl8XX3JirqyFbQp+HVeWRN+crjxCDz3j8Ayt0TDmvZNV31g
         ds5ZDgw/MTAPCP8vN6MNtYrjO7iL2cngWeuOl/rqTzteIJfH62zPC5q3W4BOo1yZ6HVb
         e1jI8+hkODy7vTTrMEJeHhHhc24hnBLT36OFJyQszx3YwapiNRU5bwoBf8N3NXfyNWbo
         R5RBdx1fA/+1unUL7ogSVAZBxsYU3VDD2U5t5TUQVeavDhM/86zMLeCtt9JREQqLCIg0
         ytWw==
X-Gm-Message-State: AJIora907bRm1Su6fz87a8X0GT05k4lI3ugRCfTAvXmOBg8blsgNK5wq
        SGlVRCeFoccTGOqqwOssvNq5oK/Tu/1tK3stuBALmg==
X-Google-Smtp-Source: AGRyM1v/G0QsAoKUthuZb0KgqKfJA0rBF7c+4uGMfldrPoAbT2ACpLKE8o2IhEgcKusJyffFBTQFFIwhCuW5q+ZFOVY=
X-Received: by 2002:a1f:ad93:0:b0:375:fa52:e845 with SMTP id
 w141-20020a1fad93000000b00375fa52e845mr507162vke.34.1658461305380; Thu, 21
 Jul 2022 20:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220721210214.043ada3e@canb.auug.org.au> <140882ed-29bb-eb0d-88da-c546d20244e9@infradead.org>
In-Reply-To: <140882ed-29bb-eb0d-88da-c546d20244e9@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Jul 2022 11:41:34 +0800
Message-ID: <CABVgOS=_76NfxpJpJVx_=R3VJZJk4TsCJDwOkp_9Cfcouu6M3g@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 21 (mmc/host & KUNIT)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 8:03 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 7/21/22 04:02, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20220720:
> >
>
> on i386:
>
> ld: drivers/mmc/host/sdhci-of-aspeed.o: in function `aspeed_sdhci_phase_ddr52':
> sdhci-of-aspeed.c:(.text+0x2a2): undefined reference to `kunit_binary_assert_format'
> ld: sdhci-of-aspeed.c:(.text+0x2c5): undefined reference to `kunit_do_failed_assertion'

<...snip...>

Thanks. This should be fixed by:
https://lore.kernel.org/linux-kselftest/20220715040354.2629856-1-davidgow@google.com/

Cheers,
-- David
