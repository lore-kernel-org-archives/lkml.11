Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AFEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377625AbiDEL34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243858AbiDEIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:51:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79EDCA0FA;
        Tue,  5 Apr 2022 01:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BBD5CCE1BCE;
        Tue,  5 Apr 2022 08:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95FFC385A3;
        Tue,  5 Apr 2022 08:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147936;
        bh=e1bQVDK7ZCYqbZ5aVCcAEwCJB5LlrMPnBXSml3bLJm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBR/QQPNDugl4/Rt0tY0cBRKTshRbWERZPjPQcyT73sWw71sKCY/t4E71Baa8dPhS
         tUA6P42aqh7j/T/p14c17wvlGM0d+ZFPOznovCtZBjvfi4zTxenVEehIQhbc64koaX
         EDvBM1ESwoYQtA5eiFt5qA8yfrrEhGTc2cghzo8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 5.16 0175/1017] media: venus: hfi_cmds: List HDR10 property as unsupported for v1 and v3
Date:   Tue,  5 Apr 2022 09:18:08 +0200
Message-Id: <20220405070359.425255248@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

commit 22beb839f48d841ec75974872863dc253d37c21c upstream.

The HFI_PROPERTY_PARAM_VENC_HDR10_PQ_SEI HFI property is not supported
on Venus v1 and v3.

cc: stable@vger.kernel.org # 5.13+
Fixes: 9172652d72f8 ("media: venus: venc: Add support for CLL and Mastering display controls")
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -1054,6 +1054,8 @@ static int pkt_session_set_property_1x(s
 		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*info);
 		break;
 	}
+	case HFI_PROPERTY_PARAM_VENC_HDR10_PQ_SEI:
+		return -ENOTSUPP;
 
 	/* FOLLOWING PROPERTIES ARE NOT IMPLEMENTED IN CORE YET */
 	case HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS:


