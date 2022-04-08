Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07028C433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 14:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiDHOtf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 10:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiDHOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:49:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557ABFC12E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5E5661E87
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56B2C385A1;
        Fri,  8 Apr 2022 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649429240;
        bh=hNoeIzZ/9lUue37m5/0DCVmwmzJBqBSrNt6+sP0ab4M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SzehU5+KL2sslGmCltvM6a+txG1+XMk9NmmM8WYJVQB5Vk1WbGUR97/OCErYNJG1m
         QDvpLzuWGDzUWSj3nJ6dXSQD2e87yizY/UEQhoTiqnnOv5A5MEoCmudGhS0XDZBPaT
         gRJGi4klLuVRrVYYi/MQAXvUIHkilH7WMGuiyjafhZ/0yT/tSpWF3xY2KbPldTgfgH
         eS6ShE30lD0ZPdJGGWVvzL3VQQ1juUYulkZGERvbGA359VvLEbmNTL++KBCIlxh2s3
         wpjfuK+Yq2oxWLdLpnZsmqaLvqASTwzwXcrpZrbfDX/98FKbdLI39RQN3R0llhF9w/
         eCm7LlVe7v60A==
From:   Mark Brown <broonie@kernel.org>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     linux-kernel@vger.kernel.org, mazziesaccount@gmail.com
In-Reply-To: <Yk/zAHusOdf4+h06@dc73szyh141qn5ck3nwqy-3.rev.dnainternet.fi>
References: <Yk/zAHusOdf4+h06@dc73szyh141qn5ck3nwqy-3.rev.dnainternet.fi>
Subject: Re: [PATCH] MAINTAINERS: Fix reviewer info for a few ROHM ICs
Message-Id: <164942923939.1424555.10954443516187448149.b4-ty@kernel.org>
Date:   Fri, 08 Apr 2022 15:47:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 11:32:00 +0300, Matti Vaittinen wrote:
> The email backend used by ROHM keeps labeling patches as spam.
> Additionally, there have been reports of some emails been completely
> dropped. Finally also the email list (or shared inbox)
> linux-power@fi.rohmeurope.com inadvertly stopped working and has not
> been reviwed during the past few weeks.
> 
> Remove no longer working list 'linux-power' list-entry and switch my
> email to use the personal gmail account instead of the company account.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] MAINTAINERS: Fix reviewer info for a few ROHM ICs
      commit: 908b768f9a8ffca2ef69f3145e23a6a259f99ac3

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
