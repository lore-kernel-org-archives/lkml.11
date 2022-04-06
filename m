Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB81C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 15:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiDFQAf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbiDFP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:59:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44442443C0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7C56615B1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C00C385A3;
        Wed,  6 Apr 2022 13:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251728;
        bh=l3divZWw+E9A2Yng2WHTTF7Ibc8GkDmAmP9AmSHkIaA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=igR6KWLHQZ2sB82z8sva1vGQ9Rhoj+O/eAap7EEG6bra0gFhrrmoJint3XuTZKfca
         XkwTf7BnoE/Ona40Y8ZUYAK2aKbbgQiFEd07ySFZl/TUwyne/i0YmNZsavmI0ZbOpQ
         mI4m/h9IacwI/GJ272sdj/YVcPr+LiD0NTQbgfXw7xGRocrG1o+e3ldH4QgZVSSA4Y
         jTWS441ZPh7O16YKEp07332UhHHI88kL6eqjmJtOnQLs6sEFTQNBMbh9DuMaYWcVBw
         WStCOuLC/mtyBFdRFQUoaoSo7bdb/43728TNve3YPOqv810EiZEIQm1IvixtbZ8YLY
         4ICQTxx9+j0Tw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tiwai@suse.com, linux-mediatek@lists.infradead.org,
        linmq006@gmail.com, ryder.lee@mediatek.com, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org,
        rikard.falkeborn@gmail.com
In-Reply-To: <20220404093526.30004-1-linmq006@gmail.com>
References: <20220404093526.30004-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: Fix missing of_node_put in mt2701_wm8960_machine_probe
Message-Id: <164925172592.83821.12895758301254596551.b4-ty@kernel.org>
Date:   Wed, 06 Apr 2022 14:28:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022 09:35:25 +0000, Miaoqian Lin wrote:
> This node pointer is returned by of_parse_phandle() with
> refcount incremented in this function.
> Calling of_node_put() to avoid the refcount leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: Fix missing of_node_put in mt2701_wm8960_machine_probe
      commit: 05654431a18fe24e5e46a375d98904134628a102

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
