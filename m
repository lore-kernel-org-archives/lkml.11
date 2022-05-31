Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D82BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 11:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbiEaLXU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 07:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiEaLXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:23:17 -0400
X-Greylist: delayed 300 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 May 2022 04:23:14 PDT
Received: from mx2.uni-rostock.de (mx2.uni-rostock.de [139.30.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41B1DD0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:23:14 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1653995891; bh=VjMMtWBmuKsAZo4+Oendr+Ytx7OgaBW8U2ZAKTBRJAQ=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 53cmFcbKSlcnHhxXmHAJd2B1/3Gr38fZ6Obodwd3iVeOgCmjibmGl4+aJR72Tnye1GPoltk/Ni9UTmZ3tS42BA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1653995891; bh=VjMMtWBmuKsAZo4+Oendr+Ytx7OgaBW8U2ZAKTBRJAQ=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 gLmCViOYeOhbAK03GLVfEcIihU2HBh+hYz/mBsZwnLYmniprjDL0tJzzccHgc5FjQIA0rQ6W27aEJxtbUnBPmz7Rg9cDsQkfALcvt5pab1PLyV8yQdc5DDFg22xkLNuL6Sh3GhLVJW+OrvUWOujXr4N4lm8M1dMmAIUTxxI22js=
Received: from 139.30.22.81 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Tue, 31 May 2022 11:18:11 GMT
Received: from meshdev.amd.e-technik.uni-rostock.de (139.30.202.94) by
 email1.uni-rostock.de (139.30.22.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 31 May 2022 13:18:11 +0200
From:   Benjamin Beichler <benjamin.beichler@uni-rostock.de>
To:     <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Beichler <benjamin.beichler@uni-rostock.de>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: remove straying parenthesis
Date:   Tue, 31 May 2022 11:17:39 +0000
Message-ID: <20220531111740.899162-1-benjamin.beichler@uni-rostock.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.30.202.94]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 email1.uni-rostock.de (139.30.22.81)
X-TM-SNTS-SMTP: 58033106F06AE73A08A0A4272B4C216BC236F2CE56B59DD1986B6C865648394D2002:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: e3a33af812c6 ("um: fix and optimize xor select template for CONFIG64 and timetravel mode")
Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/include/asm/xor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
index 22b39de73c24..647fae200c5d 100644
--- a/arch/um/include/asm/xor.h
+++ b/arch/um/include/asm/xor.h
@@ -18,7 +18,7 @@
 #undef XOR_SELECT_TEMPLATE
 /* pick an arbitrary one - measuring isn't possible with inf-cpu */
 #define XOR_SELECT_TEMPLATE(x)	\
-	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x))
+	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x)
 #endif
 
 #endif
-- 
2.25.1
