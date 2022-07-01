Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C43CC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 20:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiGAU3h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGAU3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:29:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE6838799
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 13:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F07D1B80B74
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 20:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D122FC3411E;
        Fri,  1 Jul 2022 20:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656707371;
        bh=LRv/lknPG+TK7cFzeL9s/nW+r/KwFiZfeygFv4ksOgM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fsgRBIerB9z5HYWvjNT7XVDV6eu1XnZ62DTm7R+k1unSuDM2okZUd5r6XCYKUBKE7
         L4QsJe9C4I0qHEB7SNl3/QWzbpOtCRR9wPX3meix0mcZCixS1Hcw4+dFPvnX96wwYT
         xeY2tkgbIAAW5yvLojHwYruPVqCXFwZ+Ilxf3QWEbycijAKceuTrU4Dot1K+wAcrfX
         AzS97LP5cr9YOjUXky2shCNdSbU2VggU4toKuvLzYP33K4m4o/df3abvmDV2hEehtp
         SK8UBp3BOwYf+rvihHsHM9L/Nd3aJJRi+y7LGgZLzM61PCF1v63ZFY2ouPYr3RyUi2
         +zdkOjSgs+IMQ==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org
Cc:     perex@perex.cz, linux-kernel@vger.kernel.org, lkp@intel.com,
        alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
In-Reply-To: <20220701125515.32332-1-srinivas.kandagatla@linaro.org>
References: <20220701125515.32332-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wsa883x: add missing break statement
Message-Id: <165670736945.209342.14096327749907091103.b4-ty@kernel.org>
Date:   Fri, 01 Jul 2022 21:29:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 13:55:15 +0100, Srinivas Kandagatla wrote:
> Add missing break in one of the switch statement.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa883x: add missing break statement
      commit: 68f26639dc40b5d6aca201f3e250a1538e68eae6

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
