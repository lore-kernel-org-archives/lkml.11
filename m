Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D91C28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 16:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiHVQFg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiHVQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:05:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B132C648;
        Mon, 22 Aug 2022 09:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50DFBB8124F;
        Mon, 22 Aug 2022 16:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A81C433C1;
        Mon, 22 Aug 2022 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661184330;
        bh=d3sUkYp6dks0UkiVe4t0K0fOPEi7K0LdjCO3EOU4CHU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PKaA0zHIXDboIrSbFj2n2Snj2sRRFvvZl5ts3UbD0yRBW5JmZVehRhl3HXUwnpK9o
         RAQSGvE4kXpO1JFJnJFcxlILkSPJK4S9vowAaKKiMGFq37BKFgmZWBeeXkXVEIq9Ij
         Rjn6ISoCm/Dwm83lcVU5SQFDukbSwcNySHpcRUmmFn2uv13XQz9umWVleoqmvNTbfm
         rVjMv2A8Mzg7EhXCN1bqtOqkqIImzxJePK7OmSBy6X67fegVnKLI1gxEINP4/aEHMa
         0qvEjLjC6+en6GWDytUQKHxghNuNkx4njeueghQ1sPcthh15xZ2o6hQlV+Nvem69IY
         KHgWGHm5DYxdg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>
In-Reply-To: <20220818121227.151016-1-linus.walleij@linaro.org>
References: <20220818121227.151016-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] regmap/hexagon: Properly fix the generic IO helpers
Message-Id: <166118432866.209062.6307998506272128787.b4-ty@kernel.org>
Date:   Mon, 22 Aug 2022 17:05:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 14:12:27 +0200, Linus Walleij wrote:
> I was too naive in just including <asm-generic/io.h> into
> hexagon: one has to specify defines for every call that uses
> a (static) inline or this will not work.
> 
> Fix it up by providing proper defines for all shorthands that
> hexagon provides.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap/hexagon: Properly fix the generic IO helpers
      commit: f8f60615379c1b36d9220f3886fb9b229e95d8cd

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
