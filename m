Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF966C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 20:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbiCBUuK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbiCBUtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:40 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C44FDD967
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:44 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c9so2655382pll.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5m/cqv3Mn+iGeCNDHoqe+Z9VT3KHz2Fko/1l3SMOrc=;
        b=izcLZLSJM1oBEyIaxI3ikTlntnFW8G/mJQqDzFunT2m3XSfuZXK+Fx6L+2v2hQuDNX
         Atgi6SLH15gCf+0cYbx1Snm1ZUDP7QQJf/iZHkAaK7RTgeKYVj3Ncv6m5ZGtDRduLobJ
         5Nn1LmHx8pWT7u43Fe9ADKbTj59v+sN3MJwVdUAcabl8knIcx2ZrRrNIEbSAyBkW/NZk
         ciuIb0E/VUPbfbYhB8yFb6n3JuaQYZcZFcHTSNztDWkp5cpMBKXxAF/EOA/7pP667sac
         w1KPfoQKt1/eQh/kHbNwMRWVYgXRSj0VGfblvz1LE7PB6enUfZkfWKmf4sXeAPU3ELek
         uaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5m/cqv3Mn+iGeCNDHoqe+Z9VT3KHz2Fko/1l3SMOrc=;
        b=IyBXtyzRDuUZCfLnym+NOFYTohVvp9ABXyIwgyj5kTlaPCEUjsSI9zuQY97MbormvM
         MNWvEOktyVxYgjitsQaEN2KjeaW9af6DOVmWAFaj8/aipEiY7OWxp/QIiz3UfpNnXNVG
         mKlfRnQVQdVeIevT3BPDMXCbLWqibOvUjCuxP4rja6gz8V0dfRUwVCEJLlFuetwbHP/9
         gGN4IrB50ONmdbfanUHOhu2fEMn5IUimAz5Edkvu2HrgZ+FMNz00DE75onz/Noxjzk47
         T2anr9a4qbKouIfCGhjVOHmkt/54NPf28GShMq3g/DadHRUzePoRqs6lyShIxv0tge7S
         aJ1w==
X-Gm-Message-State: AOAM530su3C2LePtasqR6tSpUCZcDYFdGB7pLpoavPwOuyPo76Rzh3en
        1igjfBSliTNvHErtiH1lksQ=
X-Google-Smtp-Source: ABdhPJx0S6YfaJ7sUkuS65oaMCO3SAZAQgVpDCTl4kScDgWskXGknukzKtSsD9s8P0XXQhTx3zjW5Q==
X-Received: by 2002:a17:902:b087:b0:151:842a:d212 with SMTP id p7-20020a170902b08700b00151842ad212mr9755227plr.92.1646254124100;
        Wed, 02 Mar 2022 12:48:44 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:43 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 13/16] staging: r8188eu: mark check_fwstate as bool
Date:   Thu,  3 Mar 2022 02:17:34 +0530
Message-Id: <20220302204737.49056-14-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302204737.49056-1-makvihas@gmail.com>
References: <20220302204737.49056-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark check_fwstate as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_mlme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index d418d57f9..42d850f9d 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -451,7 +451,7 @@ static inline u8 *get_bssid(struct mlme_priv *pmlmepriv)
 	return pmlmepriv->cur_network.network.MacAddress;
 }
 
-static inline int check_fwstate(struct mlme_priv *pmlmepriv, int state)
+static inline bool check_fwstate(struct mlme_priv *pmlmepriv, int state)
 {
 	if (pmlmepriv->fw_state & state)
 		return true;
-- 
2.30.2

