Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75937CCA488
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 11:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355097AbiFMLed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354393AbiFML31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:29:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC21B1DE;
        Mon, 13 Jun 2022 03:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95478B80D3C;
        Mon, 13 Jun 2022 10:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F56C34114;
        Mon, 13 Jun 2022 10:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655117039;
        bh=rvUmyBmDKVZDetmF797t1nO2r9n9jDok30+qzlEMTw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szC1vOLR/goFAGuwK/VHTP1AQH5i2lu2Q9hLCrqdoMdUaf17mR8c2z8loTzzw6Rt2
         4LEe6YOzEnBJvGQ2CF/3yQqIb4XdrzF2oCt0sZwm9kQkR0B/Ejyt/O9NtKfshVFGdb
         42Ti+l1Etph4z96Vopg3MYX+XH+4G2+X0XQ5dyAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kathiravan T <quic_kathirav@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.4 264/411] arm64: dts: qcom: ipq8074: fix the sleep clock frequency
Date:   Mon, 13 Jun 2022 12:08:57 +0200
Message-Id: <20220613094936.678159984@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613094928.482772422@linuxfoundation.org>
References: <20220613094928.482772422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kathiravan T <quic_kathirav@quicinc.com>

commit f607dd767f5d6800ffbdce5b99ba81763b023781 upstream.

Sleep clock frequency should be 32768Hz. Lets fix it.

Cc: stable@vger.kernel.org
Fixes: 41dac73e243d ("arm64: dts: Add ipq8074 SoC and HK01 board support")
Link: https://lore.kernel.org/all/e2a447f8-6024-0369-f698-2027b6edcf9e@codeaurora.org/
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/1644581655-11568-1-git-send-email-quic_kathirav@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -482,7 +482,7 @@
 	clocks {
 		sleep_clk: sleep_clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32768>;
 			#clock-cells = <0>;
 		};
 


