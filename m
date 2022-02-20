Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C38FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Feb 2022 10:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiBTKDU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 05:03:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbiBTKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:02:58 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED73AA58
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:02:22 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c6so20675734edk.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2xZHeiG083yzKkuwwrfxDMOHMTEvS0BBe2aT8XTSjE=;
        b=hMWAPNYnvQO0lcnti8nUKnHcotk1QbkXffJrttbjhU0QA3s/lyGM003DzA2UBvGB3a
         8ZVw1TtigbpjW3DT3EltENukaIMcvit5TKjh55hTAVgaXbHOrxrSiIGRxmZq3h4+ECMy
         ndfEUzSI4Fz6zG5A1KLhpWQIdO8ehQfW6nH0JkLQkZh68i+LAcapXps4N98PDk36bRsb
         splozHraOAcPsv+8nlKwsnJcr3NT4nQ3S7/05DlqWUKPK+mMs8Itl7e6pch3RB8CtdfQ
         YxpfJDMELoLBw8MwGRZtoAfEyxBhiO3r9TrC5f9w8B0vYb82qTho29ER9UF8EyOsa+/y
         etkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2xZHeiG083yzKkuwwrfxDMOHMTEvS0BBe2aT8XTSjE=;
        b=WZNfmoUcFC1gRR821RUq7GiAAuU2oTXBaWPBTgldYGnvwJOO3ep7n7z5UhMO74cidi
         9PWwi8yfKp0mGc6ca5StaaxpVid7lXaVI05UErfBgacQUyndMQy6R4E0fYA+FPkrPVh/
         H1fyv9hjg6SKhg16we0GXMpWhkjlpKW5BOMmq6kIgxcKBv4vWjxQMjS/lfVd9IF+nGKi
         hE1zT2P903wei+UOogg6fuhV4Tj1VIOxAMYFaiV2u0kccSKcq269Z51p+K+5Zfh7XygI
         rbt2r40F/7Bh2mdboqAifKAGI6eQgB1OudKzCWPw3qIIMyLHr4YTXM0VfMrCaXJhqHXp
         z4mA==
X-Gm-Message-State: AOAM532KJ+HL1YyQu8h1zNGnZ9afapVJ8r7Ib0Sy3LnG+UHfNu/xjzjH
        p1jaAZoltVCvvC00UE0ne94=
X-Google-Smtp-Source: ABdhPJzsB8+zYF+59/WpSNP/RSH7bKKUEtglBIWA5Bhy3x3nyt1rD4nxG82nO/B3HckRampxq8Y6oQ==
X-Received: by 2002:aa7:d1d7:0:b0:410:d6cf:82b2 with SMTP id g23-20020aa7d1d7000000b00410d6cf82b2mr15799003edp.193.1645351340717;
        Sun, 20 Feb 2022 02:02:20 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id dx7sm3265223ejb.23.2022.02.20.02.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 02:02:20 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: convert two u8 variables to bool
Date:   Sun, 20 Feb 2022 11:02:09 +0100
Message-Id: <20220220100212.7466-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220100212.7466-1-straube.linux@gmail.com>
References: <20220220100212.7466-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables bScanInProcess in struct mlme_priv and bpower_saving in
struct pwrctrl_priv are both unsed to store only boolean values true
and false. Convert them from u8 to bool to avoid type casts in the
function Update_ODM_ComInfo_88E().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 4 ++--
 drivers/staging/r8188eu/include/rtw_mlme.h    | 2 +-
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 09e78c4855f9..082104c9b2e8 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -42,8 +42,8 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	dm_odm->pSecChOffset = &hal_data->nCur40MhzPrimeSC;
 	dm_odm->pBandWidth = (u8 *)&hal_data->CurrentChannelBW;
 	dm_odm->pChannel = &hal_data->CurrentChannel;
-	dm_odm->pbScanInProcess = (bool *)&pmlmepriv->bScanInProcess;
-	dm_odm->pbPowerSaving = (bool *)&pwrctrlpriv->bpower_saving;
+	dm_odm->pbScanInProcess = &pmlmepriv->bScanInProcess;
+	dm_odm->pbPowerSaving = &pwrctrlpriv->bpower_saving;
 
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
 
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 1e16fa615b94..d418d57f99b6 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -310,7 +310,7 @@ struct qos_priv {
 struct mlme_priv {
 	spinlock_t lock;
 	int fw_state;	/* shall we protect this variable? maybe not necessarily... */
-	u8 bScanInProcess;
+	bool bScanInProcess;
 	u8 to_join; /* flag */
 	u8 to_roaming; /*  roaming trying times */
 
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 2d5298373d74..7c3cb895c3cd 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -49,7 +49,7 @@ struct pwrctrl_priv {
 
 	u32	alives;
 	struct work_struct cpwm_event;
-	u8	bpower_saving;
+	bool	bpower_saving;
 
 	u8	reg_rfoff;
 	u8	reg_pdnmode; /* powerdown mode */
-- 
2.35.1

