Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF3C35280
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387288AbiDEVvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442791AbiDEPiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB717A2FE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A6E61909
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817C3C385A0;
        Tue,  5 Apr 2022 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649166801;
        bh=uRCqPiSmDm50AsV2xR5Q4AxiYFD6rvyaw7Au70Xqr6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIXABeKSO6EetTKWYp/B5wn78lHER0NNxbIHWF/2eiybNzyn9aktzwdpguALXmIpF
         FWI21vFN+mRcQSaSTG5aXuVGdFLq/ypYu30dPI9Z95oXio+45gge2I6NY+pHCyStCw
         Ww/qvoFlCqJtZibYrVUBDULM3FtU4oUYVcGPPfNXAbIzjq8lTB60F+ouM1xAVJWeY8
         IrClZPQ7ovoG7/feMaWLd2/2Vdp62Qg/XLfkxNMJWMZq9Qlgcm+ZnxVt6JojQtLDuh
         gBHnqpXU3O09/W4gviRTs/T3B/V7xE4fa7/HlgoJhTCrLrLBoGXHcmz1Va1swAvwVT
         Aj4HkAwCvZTfQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nbjcV-001lTa-71; Tue, 05 Apr 2022 15:53:19 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 2/2] ASoC: Intel: sof_es8336: Huawei Matebook D15 uses a headphone gpio
Date:   Tue,  5 Apr 2022 15:53:17 +0200
Message-Id: <2e5821bf815a97786d2b58c62dcef98bc7b19ed8.1649166634.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649166634.git.mchehab@kernel.org>
References: <cover.1649166634.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on experimental tests, Huawei Matebook D15 actually uses
both gpio0 and gpio1: the first one controls the speaker, while
the other one controls the headphone.

Add a quirk for that.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v2 RESEND 0/2] at: https://lore.kernel.org/all/cover.1649166634.git.mchehab@kernel.org/

 sound/soc/intel/boards/sof_es8336.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index bcd80870d252..79cf9777c4fc 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -292,6 +292,14 @@ static const struct dmi_system_id sof_es8336_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOF_ES8336_TGL_GPIO_QUIRK)
 	},
+	{
+		.callback = sof_es8336_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_BOARD_NAME, "BOHB-WAX9-PCB-B2"),
+		},
+		.driver_data = (void *)(SOF_ES8336_HEADPHONE_GPIO)
+	},
 	{}
 };
 
-- 
2.35.1

