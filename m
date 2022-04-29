Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6295DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Apr 2022 13:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376327AbiD2NnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Apr 2022 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbiD2Nmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D42CABBD;
        Fri, 29 Apr 2022 06:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC39622ED;
        Fri, 29 Apr 2022 13:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E906C385A7;
        Fri, 29 Apr 2022 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651239572;
        bh=XNWImAgELpmMpTBF7HRmj5EHdcm/y1j2YjyOR9iCWPQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eSNgODsNffZd6pvCny4T5+Q3CNetfbfkM89iyh2ZAfsItpNBiupCFluvDcizXrjLv
         eYoP83OjM/kR9mDYIsfooZ+z76qVtltw6B+7Y9Xaaz9hjaUCn0J3Xx/pWwRzQey9Q/
         qKP8D8uA1ns0IpMdt7UM3Ewae2oHfGP86q7x/3JbvclTSuqUD8HZCMgAfM4LYmMSNS
         dEM8QtHHWJCRRLamMojFU19q2bzR8VP7o2nfMVWSh32xUij83j62wurXV6blXXc+8r
         vbWHgZyMC8aw1PzQDhrLlsAJ1xMMV+a2UVbsjJP6Tx3M5/tuCtOXqDfhGabUGedmgL
         vZeDKc17i4jag==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, markuss.broks@gmail.com,
        robh+dt@kernel.org, lee.jones@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org
In-Reply-To: <20220429120914.9928-1-markuss.broks@gmail.com>
References: <20220429120914.9928-1-markuss.broks@gmail.com>
Subject: Re: [PATCH] regulator: sm5703: Correct reference to the common regulator schema
Message-Id: <165123957102.69493.14378315784556082108.b4-ty@kernel.org>
Date:   Fri, 29 Apr 2022 14:39:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 15:09:14 +0300, Markuss Broks wrote:
> The correct file name is regulator.yaml, not regulators.yaml.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: sm5703: Correct reference to the common regulator schema
      commit: dc6d04619e62825083926929d88c94c5b6b42670

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
