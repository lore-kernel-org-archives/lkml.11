Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D31CCA48C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 21:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiGVVzb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiGVVzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:25 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1DCDE9C;
        Fri, 22 Jul 2022 14:55:23 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MKpGg-1oF0bu47CS-0006R2;
 Fri, 22 Jul 2022 23:55:03 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] ARM: dts: imx6qdl-mba6: don't use multiple blank lines
Date:   Fri, 22 Jul 2022 23:54:35 +0200
Message-Id: <20220722215445.3548530-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HgVZp8uugr991YsIEXxXp+Nn0wfyTlePiZbW0uG2yqq6p7Y28kt
 0A5hbIjYpM5SZBtsSNJM2Z8Lqu1iXLaDt0ssNh41o+Gisw/YIsyZzBsILe13lr4Z9ZsAcjf
 C1FoB/2nyDXEmqYr5fFxDkWokJrD7EvPXELPSxrdtrmmanX2NsCQieEpX141D6teCxn8ybB
 mWvkXZglP/WPXf5ewxavw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5h1ru4zxD+U=:KGil5eeBEbOdV5YYlz2yyA
 cmScE2zSdaXqceIiW223AFu0te/IAUNsp+nuq8WpCwHq/OMOARo3ln9VKhKRiVCAIhnIjhgm7
 a6eU26q7vdeaG3+dNIZwwHojJmdgfZOEoV1KB0twM/OxNWD26Z9LJ1blHfncAqARjWDdzOwqT
 LZ6PFrC3GsTn05wixcpsXfNjYjToSIMkKvbhxn5barXnQyVq6jN/cct9n3BbA8N58oB+xPdE3
 pe3m7HBc93ntHVWPwdCGXtzWMwx+36DBfeMcxD9hIcXuXNoJVgqUxq9y1gzARNHK4wOJw9KYC
 PLKiHRNCaW/kO6PzEPRsFnxZZ27vb0Plal9bzRwfmz4lnZjA9CEFUnEuRY1d9CubHqkL5Uzxy
 xVDuurukHgv4i5y23JAT2/MGIUodCU/io/t1pXnUro/qGzRYOjsAGUd+VFxielZqHHU9Qficj
 36Q4+rVWyNM5nX1gikvbT2y98snuLB6qcKd1JcmPhbrG9DQV+7+VU+jaXmnoX0YWR1punRvbh
 IhrY3zP+YKgD1F9gjYZvuWCgFVxRENig5sQ8rvB3rMO6G51iRPmgs27c4tpTvraIHStQcLhr2
 zX//3msI44vawcolqOp0ubm2qGGenfMxb0Y8U3Jmj8hgVzh7e5WJe7+DsaLyYRoth8kbxoI5M
 fC1F0gb8oaVJlA4MSy+8dgHa1ZTO/ytb1UDXvIksN+n8VSZWhh1pFkKNqjDG0sZMdp3YPAYUE
 qli0ZrTxiAQCOlzUh6Hmo5zd3u9Zt9wTmrcFAKmAbwab3IRjOYFDtuQBoHw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid the following checkpatch warning:

arch/arm/boot/dts/imx6qdl-mba6.dtsi:247: check: Please don't use
 multiple blank lines

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>

---

Changes in v2:
- Add Alexander's acked-by. Thanks!

 arch/arm/boot/dts/imx6qdl-mba6.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-mba6.dtsi b/arch/arm/boot/dts/imx6qdl-mba6.dtsi
index f4dca20669d6..78555a618851 100644
--- a/arch/arm/boot/dts/imx6qdl-mba6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-mba6.dtsi
@@ -244,7 +244,6 @@ &uart2 {
 	status = "okay";
 };
 
-
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
-- 
2.35.1

