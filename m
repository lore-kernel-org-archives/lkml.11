Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA941C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 20:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbiEDUkr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 16:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiEDUkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F54E18B2C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:37:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2D3A617C2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 20:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FCAC385A5;
        Wed,  4 May 2022 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651696624;
        bh=qmimBDeRB4bB+AEAXOitKu5QJGWKCNVo/BZKGvVdtVA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Sjitd1DX16hJEzOOafTZ/yM2kGICPQVsuLAxt3lxQtAAmyVNyFbWHO76ifP4mhsqW
         53KmUBq5IES+7vwcZE+UipR7uqZ6ZNeuaAANBeyHPq+n0BE1knxPChCsLbVusOK2le
         y19UXnxN/coVoDC038Ei+jt7cT4rZ3RiBYXaFOh8v1058BBJQLIenLRCVvQ1dpvaBO
         KDIRnJOwtaZzTCPS4Arv/eLutvzrhy5TxVQtZCUhSbz2xUhevsBQ+vVo61fpJpuS5t
         /0sjRPo7xzCJ9IldtGCqm0CR0mmRb8FCc47pum8dRcq42xMqMCBlCinQkFFPOseGZE
         4RlDOFGXRGy+Q==
From:   Mark Brown <broonie@kernel.org>
To:     rf@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220504134458.283780-1-rf@opensource.cirrus.com>
References: <20220504134458.283780-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l45: Enable BOOST
Message-Id: <165169662327.1744642.12027482630196745808.b4-ty@kernel.org>
Date:   Wed, 04 May 2022 21:37:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 14:44:58 +0100, Richard Fitzgerald wrote:
> Do not disable the boost converter during probe. The silicon
> contains functional default tunings so the boost converter can
> be left at the chip default enabled state.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l45: Enable BOOST
      commit: 6ff98a694cc114fd79f692345a7fbd469f800f8c

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
