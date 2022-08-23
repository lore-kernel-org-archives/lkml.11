Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81101C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 17:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiHWRmi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiHWRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:41:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FA275FE7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FE92B81CED
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C33C433B5;
        Tue, 23 Aug 2022 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661269157;
        bh=EY7ffbopHvWsKpBVtYBIrPDSyaNtMo8vstLMv2RbPi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4cLF4ai88z/mqbFHfObkZHkx3eEi9LrgQNCu7fhOmP7r/F+1Nbz9zwGAI7WQkkJm
         M7mrxmZk6dSxVjdCXZCxnh3upzNpqzq8AMMlB+iXd/8UcwIYN2YyK9E2U6yKEVT70E
         KXaE7WVPdZKyOWP1DSMbaZxspsvmlQ0zGizbNpNDwyZ1Rd7xVxlpoIwLzfEkYi9sCQ
         vAmSz40YIMt3v6Z8gC1A5CyZfqg4yUWTja65AZMkdCvEJJwVsbS2sy6T1Qari0jJow
         TUI0EuTu5TiWchDhjT3A7bKme6PtqyolERQg1j5heVQ0PXDqZnzK7dJTo8dahQKadt
         Xo+9oKO4geaFQ==
Date:   Tue, 23 Aug 2022 08:39:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        llvm@lists.linux.dev,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] ASoC: mchp-spdiftx: Fix clang
 -Wbitfield-constant-conversion
Message-ID: <YwT0oUjo/lzBDRdH@dev-arch.thelio-3990X>
References: <20220810010809.2024482-1-nathan@kernel.org>
 <166058059542.769843.4941839393289864947.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166058059542.769843.4941839393289864947.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Aug 15, 2022 at 05:23:15PM +0100, Mark Brown wrote:
> On Tue, 9 Aug 2022 18:08:09 -0700, Nathan Chancellor wrote:
> > A recent change in clang strengthened its -Wbitfield-constant-conversion
> > to warn when 1 is assigned to a 1-bit signed integer bitfield, as it can
> > only be 0 or -1, not 1:
> > 
> >   sound/soc/atmel/mchp-spdiftx.c:505:20: error: implicit truncation from 'int' to bit-field changes value from 1 to -1 [-Werror,-Wbitfield-constant-conversion]
> >           dev->gclk_enabled = 1;
> >                             ^ ~
> >   1 error generated.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: mchp-spdiftx: Fix clang -Wbitfield-constant-conversion
>       commit: eab9100d9898cbd37882b04415b12156f8942f18

I noticed that this was applied to for-6.1. I know you do not rebase or
change your trees so this request might be rejected based on that alone
but would it be possible to cherry-pick this to for-6.0 so that it can
be applied to Linus's tree quicker? We have had to apply this change to
our CI to keep our builds green in mainline, -tip, and 5.19/5.15 stable
with clang-16 due to -Werror. If not, no worries, I should have made it
clearer that is what I was looking for with the subject prefix.

Cheers,
Nathan
