Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F0DC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 10:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353113AbiHWKOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352782AbiHWKGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:06:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB4BC0F;
        Tue, 23 Aug 2022 01:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A87BBB81C28;
        Tue, 23 Aug 2022 08:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CF4C433D6;
        Tue, 23 Aug 2022 08:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661244774;
        bh=ROwYacelnhogMjbaFhx5Z+LfPE39x335YCVt9z0dvRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRn1ejosB9+EBAl7NaJJ5n3KpQoDgDmQHwcAjLCxCejVq7LYKtDl09qB2tIpHu6KS
         lJ7hZkr7PFQ/w+IsNS9S9e1KBI4eAtDzO2gIV9vB5bPMCb8KOFBvu71YHAgoNDiqHO
         JiqAaCWwho5bSQfUxk4G78/qSS7HFCtMEcEm5q/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 188/229] pinctrl: nomadik: Fix refcount leak in nmk_pinctrl_dt_subnode_to_map
Date:   Tue, 23 Aug 2022 10:25:49 +0200
Message-Id: <20220823080100.324783308@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080053.202747790@linuxfoundation.org>
References: <20220823080053.202747790@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

commit 4b32e054335ea0ce50967f63a7bfd4db058b14b9 upstream.

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak."

Fixes: c2f6d059abfc ("pinctrl: nomadik: refactor DT parser to take two paths")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20220607111602.57355-1-linmq006@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1455,8 +1455,10 @@ static int nmk_pinctrl_dt_subnode_to_map
 
 	has_config = nmk_pinctrl_dt_get_config(np, &configs);
 	np_config = of_parse_phandle(np, "ste,config", 0);
-	if (np_config)
+	if (np_config) {
 		has_config |= nmk_pinctrl_dt_get_config(np_config, &configs);
+		of_node_put(np_config);
+	}
 	if (has_config) {
 		const char *gpio_name;
 		const char *pin;


