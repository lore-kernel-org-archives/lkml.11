Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341C6C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 16:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358244AbiDBQhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Apr 2022 12:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358223AbiDBQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38851066DB;
        Sat,  2 Apr 2022 09:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F79360B64;
        Sat,  2 Apr 2022 16:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75363C340EE;
        Sat,  2 Apr 2022 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648917345;
        bh=mkH8uJWXxF9WDJTF9GQSX6lH/7+pN83clSgWCPk/tJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D+vCMtlg9wDUXQg/1cudIhkrlzFEBvMJLjDtXPGF/NvH4Xf47sqh62KthhKdR+JXa
         LJGA1LnSyvtEtBiRRRWGRHlWjGwVChU+dKFQyWnB9XKz44tXdU8ojeIEPt20lhsUtg
         mEkd/l2Dv/uBr5Pi9MLjTNSQWYRnPpuD3kWCBMui0SB4o1OaAQcJah9ziEcge2NAqL
         6SgZCAg/Lyz6Rt4hqR5sjYWqYq7z/eVM51i+Ht/Lfg8QqCDHaMXZTYt+0+/BZxyj9E
         VbXvm2Chj8ah0B5D05Vl0Ncwohdjc9LuLajNvi9IMkw70d+p3+XeVeYN3RK0jo4Sbb
         vygZfZxO56STA==
Date:   Sat, 2 Apr 2022 18:35:39 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.16 54/59] ASoC: Intel: sof_es8336: log all
 quirks
Message-ID: <20220402183539.738ffb7b@coco.lan>
In-Reply-To: <20220330114831.1670235-54-sashal@kernel.org>
References: <20220330114831.1670235-1-sashal@kernel.org>
        <20220330114831.1670235-54-sashal@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Sasha,

Em Wed, 30 Mar 2022 07:48:26 -0400
Sasha Levin <sashal@kernel.org> escreveu:

> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> [ Upstream commit 9c818d849192491a8799b1cb14ca0f7aead4fb09 ]
> 
> We only logged the SSP quirk, make sure the GPIO and DMIC quirks are
> exposed.

Checking the backports for sof_es8336, it would be nice to also
backport this one:

	https://lore.kernel.org/all/20220308192610.392950-20-pierre-louis.bossart@linux.intel.com/

Without that, UCM won't detect a digital microphone and would fallback
to analog mic, which won't work on machines with digital mic.

-

Btw, I'm testing those using upstream UCM plus a couple of fixes
I applied on the top of it:

	https://github.com/mchehab/alsa-ucm-conf/commits/master

there's a pending PR#144 for upstream's alsa-ucm-conf fixing 3
issues at the UCM logic for essx8336.

Tested on a Huawei Matebook D15 notebook.

Thanks,
Mauro
