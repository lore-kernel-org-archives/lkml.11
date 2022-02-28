Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A78C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 19:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiB1TQm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 14:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiB1TQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:16:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A6E3C56
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:15:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FD80B815CB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0156FC340F5;
        Mon, 28 Feb 2022 19:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646075744;
        bh=xHBsD9njTJf8xrmd/MxM7baA+gAbquRLplB4hpTw1Rs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=es7cRgYS6f7DNcWE/zmLa+CZZQjBI/eK041zEQFofaZGFYC4Z0+O/1IFEi64MhjO/
         V7zmAKD9NhiOZvQ0EsQ8VfDO63J9Ejbu0oPzPkckDCXKYoeYmcA395gOHU+hD4G2ON
         dgTdJfXDFoXhoAwtDnCS9TZcmGS9Z2+lDPSQeti4jKPqpYgPWOTXsD2WWDgzPKVmM6
         8/d8ZQH7jRAZFJhZfiKIGzgS4aXgZfpg6sSTQeVO8YLBEt+S4bz7jvqEOG2yLCNJjR
         GqRnR66fBwSxYzMsgFKhtPhra+J14tWyfK+jPUotvoKx/Ut0NsQZk38IaQjsfeDHsE
         yTSfAPg+Ue1Pw==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        Meng Tang <tangmeng@uniontech.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220227050928.32270-1-tangmeng@uniontech.com>
References: <20220227050928.32270-1-tangmeng@uniontech.com>
Subject: Re: [PATCH] ASoC: amd: pcm-dma: Use platform_get_irq() to get the interrupt
Message-Id: <164607574272.3538791.6539918735401547519.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 19:15:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 13:09:28 +0800, Meng Tang wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: pcm-dma: Use platform_get_irq() to get the interrupt
      commit: 87d71a12877114b4ad60ce5b93482505bac88d6e

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
