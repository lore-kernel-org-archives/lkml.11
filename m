Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17292C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 12:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347306AbiCUM13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbiCUM1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF5956200
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6084B60F5B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95428C340E8;
        Mon, 21 Mar 2022 12:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647865557;
        bh=8Qpt35h+wLGAVt96Yq3Nv+Cm4lUtawMA5bqmOoaXN1s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PgyixpbDxbHkWA840WoY8gjMeboqxonqZKHfZfVXTbgBpF71pej2icZJIeu0yDZkj
         ca6OR7tSH+1L09pdCmdE0iQ6MnrzsQzM0+tiddeMRjIP2VIp39C1t/HO7nbflDQek/
         WjPZmWW7AHEz32FxmA+z3mNmsQdW6mM1tcHZMbiey82TvLet1KOkqW+3XlJ+BTyvnl
         RoIvLPpf7LYDJAIN7CCACS7kZVYAoPXHHyWI6lnldm40Ek4Ee/p0k/cYmh6EsyxMbi
         jxc2MHOI0zIUy3+DbVx1EUy3HiUdme6VzElWH+SlMmMOYt11+JphOJ2eseymeuGsFK
         LSy0eQbuj0Peg==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Meng Tang <tangmeng@uniontech.com>,
        festevam@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, lgirdwood@gmail.com, perex@perex.cz
Cc:     linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220321065754.18307-1-tangmeng@uniontech.com>
References: <20220321065754.18307-1-tangmeng@uniontech.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Fix jack_event() always return 0
Message-Id: <164786555531.1723641.18058789746411582644.b4-ty@kernel.org>
Date:   Mon, 21 Mar 2022 12:25:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 14:57:54 +0800, Meng Tang wrote:
> Today, hp_jack_event and mic_jack_event always return 0. However,
> snd_soc_dapm_disable_pin and snd_soc_dapm_enable_pin may return a
> non-zero value, this will cause the user who calling hp_jack_event
> and mic_jack_event don't know whether the operation was really
> successfully.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: fsl-asoc-card: Fix jack_event() always return 0
      commit: 5cb90dcb6ad569f4968da6dd841db10b91df5642

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
