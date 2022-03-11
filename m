Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C886C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 20:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351197AbiCKUXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 15:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344828AbiCKUXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:23:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D9E43EC2;
        Fri, 11 Mar 2022 12:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD5161F72;
        Fri, 11 Mar 2022 20:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7A0C340EC;
        Fri, 11 Mar 2022 20:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647030158;
        bh=ij5VNrvsFSwVimJAGBzflRTGoXGWzMpxgzmX4BZ5YPM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HHNaw7dTrZhU8k9UkXkpKfOG0tJZfuBuqv9Cnw/jdFmXn7Roa1c5D0seA0jWQQE3+
         PPperXekmJv4dIX8v++kZu5+di4c56v490qAun1wq/d2+gvDWT42ko/5Hck3Ac9VF3
         5hroXOwdq3hyDD+PpEvHbgi7iDGJea/QZ2BPhuxIHTAhiTRPVQchCF3adPou0k2X0d
         KCaRlbsFteozlEa0juMWWUChr1gWNL0Py1EA5ReWQuqsP5ireRzSV4ZvjOe5Ka6+e9
         pby/qGRugO9UdzPT6P3j4XCQnHSejOORcX8XORNW+iuIhmeMhyQW5JafYtRWmCx4rr
         9NnHSLA9zMqYg==
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>, tiwai@suse.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        aaronyu@google.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yc.hung@mediatek.com
In-Reply-To: <20220308072435.22460-1-trevor.wu@mediatek.com>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
Subject: Re: (subset) [PATCH 0/5] ASoC: mediatek: Add support for MT8195 sound card with max98390 and rt5682
Message-Id: <164703015624.264137.9730451216130586080.b4-ty@kernel.org>
Date:   Fri, 11 Mar 2022 20:22:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 15:24:30 +0800, Trevor Wu wrote:
> This series of patches adds support for mt8195 board with mt6359, max98390
> and rt5682.
> 
> Reset controller is included because mt8195 etdm is used to play sound via
> max98390 before kernel boot.
> 
> In addition, the common part of machine driver is extracted for
> simplification.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: mediatek: mt8195: add reset controller
      commit: f67084148dac015d059c64f25e57abd0ab18946c
[2/5] dt-bindings: mediatek: mt8195: add reset property
      commit: ee7f79a81a27c47088fe0af95788621644826d91

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
