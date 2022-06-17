Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBF2C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 14:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382868AbiFQOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiFQOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:47:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D8F4F1D0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:47:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r1so4056491plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UbGxgyfmTUw0NnY5/Pu/ELaJtqQmXlFiXmZPB/RD9VQ=;
        b=EtFIhReR/VrsaLes7CWiYHpiTlq/afJjL0EVWAAAfLSj4MTGpOiPSSGfnuZNp7ONz2
         rTQYLkSeT19bus+HtBdYu1vr/QuzPJPvcBN9x8FwY2IHccDUoFL+pkEo2j8cmwtYwWbQ
         d8raUDOMFwVsl5g/VbnwtRmRM8y0NeoRRzNydUSJa2Ro5VKUAQznalmwEsYLGYFIM3H2
         rkDsb8f1KbPgDKpkAR5q7+RqXyNrQ0QAlp/PHqaJC/QO+g7laVUdChsb+cGZBpMRVC1O
         dqHvruBAsyeEZ2Cg+ffLFncecfOkhX0Qy5GAtCh5X/glJonQSGCadXeDuh/UEX9Orr1U
         R18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UbGxgyfmTUw0NnY5/Pu/ELaJtqQmXlFiXmZPB/RD9VQ=;
        b=7N6qIrosxdD+GLWWll7uQ3Rib7S3sG3ckqtuv9xjSadQhF63qYS1AwcWzrFXrkFYKx
         NSgsauPi/V0nPEm5+cd0VW4SAapWiZKVk9FFLUPBkwGE59kQKeBdOU+kM+3FBWT492DY
         WoO4kbBweeVrAs2zr+MScnNOlp3bjkdYtkDnKk8zrELUUNZo/tpe/u7Ph3/eptEXWf4Y
         jJeg+YdgQfQS22+IuI2UyKdzyrbyizbHQcVJ/d1PObAkSQn2yBKnN1FPrig2Xth+uUDD
         I7cmf74teqL5J3DGy3ptbrzZxGHMvFTIuzWsh4Md5Ll+GbAcgidhUGEjhspNIL7EH8Nn
         7ZmA==
X-Gm-Message-State: AJIora/ejhFPHKrKpypW4zPNedGP/fv0pxfwqBE65RhqMJA7mFVMHv5l
        PGulTgRiEvCq8ckb+3/pGjNLjxGDQ7jEow==
X-Google-Smtp-Source: AGRyM1tum7b4bQlo0bn7rZcu0diiYEHY2d4TetrZP/eW5itMJ6Z80RA5rhxIKV96EfB9ZYQulzIa1A==
X-Received: by 2002:a17:90a:6602:b0:1e3:17e:6290 with SMTP id l2-20020a17090a660200b001e3017e6290mr11189285pjj.37.1655477232496;
        Fri, 17 Jun 2022 07:47:12 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id o12-20020a63a80c000000b003db822e2170sm3832453pgf.23.2022.06.17.07.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:47:12 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Ivan Djelic <ivan.djelic@parrot.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH v2 1/5] rslib: Fix incorrect documentation of rs_modnn()
Date:   Fri, 17 Jun 2022 22:46:20 +0800
Message-Id: <20220617144624.158973-2-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220617144624.158973-1-zhangboyang.id@gmail.com>
References: <20220617144624.158973-1-zhangboyang.id@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous documentation of rs_modnn() states simple arithmetic modulo
return a wrong result for values >= (3 * rs->nn). However, that is not
true. The rs_modnn() does the exactly same job as (x % rs->nn). This can
be proved from following loop invariants:

  while (x >= rs->nn) {
    x -= rs->nn; // (1)
    x = (x >> rs->mm) + (x & rs->nn); // (2)
  }

Let x0 denote the value of x before assignment. At (1), it is obvious
that x % nn == x0 % nn. At (2), because nn == ((1 << mm) - 1), we have

  x0 % nn == x0 % nn
  x0 % nn == (((x0 >> mm) << mm) + (x0 & nn)) % nn
  x0 % nn == ((x0 >> mm) * (nn + 1) + (x0 & nn)) % nn
  x0 % nn == ((x0 >> mm) * ((nn + 1) % nn) + (x0 & nn)) % nn
  x0 % nn == ((x0 >> mm) * 1 + (x0 & nn)) % nn   // let's assume nn > 1
  x0 % nn == ((x0 >> mm) + (x0 & nn)) % nn
  x0 % nn == x % nn

When the loop exits, it is obvious that 0 <= x < nn, so the return value
must equal to (x % rs->nn).

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 238bb85243d3..507fa14c03b2 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -116,8 +116,7 @@ void free_rs(struct rs_control *rs);
  *  rs->mm = number of bits per symbol
  *  rs->nn = (2^rs->mm) - 1
  *
- *  Simple arithmetic modulo would return a wrong result for values
- *  >= 3 * rs->nn
+ *  Calculate (x % rs->nn), without using a div instruction
 */
 static inline int rs_modnn(struct rs_codec *rs, int x)
 {
-- 
2.30.2

