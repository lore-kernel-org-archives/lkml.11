Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14119C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 20:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356221AbiDEUQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 16:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357315AbiDEK0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:26:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E32436B4A;
        Tue,  5 Apr 2022 03:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D611B81C8A;
        Tue,  5 Apr 2022 10:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A98C385A1;
        Tue,  5 Apr 2022 10:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153397;
        bh=nsMVqSRmbTxbVvk5/HlwdAtS8BXE3eHLwo+t3A5U5NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mx3wquoogz9Ewj0P2CLiutDkq1Oto/U3+ejxvX9AYMY+4ljseW41UaZ4UoFq6ZuYb
         XFRbATKQgetodSRa50W0MY9BlxIVgd4uaeOEewSWu3tl7r/UyBLh8Sm58aHicuy6TP
         a8kgZeNQ4KefIDfji+vt5+TPf1B0PHBelGwm070Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, devicetree@vger.kernel.org,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 209/599] arm64: dts: qcom: sm8150: Correct TCS configuration for apps rsc
Date:   Tue,  5 Apr 2022 09:28:23 +0200
Message-Id: <20220405070305.060056814@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maulik Shah <quic_mkshah@quicinc.com>

[ Upstream commit 17ac8af678b6da6a8f1df7da8ebf2c5198741827 ]

Correct the TCS config by updating the number of TCSes for each type.

Cc: devicetree@vger.kernel.org
Fixes: d8cf9372b654 ("arm64: dts: qcom: sm8150: Add apps shared nodes")
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/1641749107-31979-2-git-send-email-quic_mkshah@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 1aec54590a11..a8a47378ba68 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1114,9 +1114,9 @@
 			qcom,tcs-offset = <0xd00>;
 			qcom,drv-id = <2>;
 			qcom,tcs-config = <ACTIVE_TCS  2>,
-					  <SLEEP_TCS   1>,
-					  <WAKE_TCS    1>,
-					  <CONTROL_TCS 0>;
+					  <SLEEP_TCS   3>,
+					  <WAKE_TCS    3>,
+					  <CONTROL_TCS 1>;
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,sm8150-rpmh-clk";
-- 
2.34.1



