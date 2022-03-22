Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32407C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 10:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiCVKXr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiCVKXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:23:31 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A70811A7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:22:00 -0700 (PDT)
Received: from integral2.. (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 518A57E33D;
        Tue, 22 Mar 2022 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647944520;
        bh=hiJ9XJQoRgMa4/fOsRSCSX7gvGvKUHkqA0mcpuI4lqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiId7k7nK05JcFz25EpP9QwMckMfGq8uRCIBPB502ocHCAJcJs/TMlGzyrNVjAP6X
         9x5LBwkE6kgRu8yXphis65A8JsYykGjUw/VgNSCwmyPZKsQ5J1lJ7dtVuCvysG9wJ/
         VYO4vNaNqa8L1cyohARBq/OmIpm40LniLsNk2wZDWlrBeshuNVZZ1Xd2xasKfg2tww
         nfQcZicD+NmVWJfHs5oM8Girks6EsAV/M0g7EGrJg93/mogpafTBU857OnB5fjls0j
         KO/BYpyhByauLwl6zYOAaVtxFPJ8sUQOmQQuzaqVStMrOc84H2oZ4dWhB2Yx47ALh1
         d6O4rSwBoXTQQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v2 7/8] tools/nolibc/string: Implement `strnlen()`
Date:   Tue, 22 Mar 2022 17:21:14 +0700
Message-Id: <20220322102115.186179-8-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  size_t strnlen(const char *str, size_t maxlen);

The strnlen() function returns the number of bytes in the string
pointed to by sstr, excluding the terminating null byte ('\0'), but at
most maxlen. In doing this, strnlen() looks only at the first maxlen
characters in the string pointed to by str and never beyond str[maxlen-1].

The first use case of this function is for determining the memory
allocation size in the strndup() function.

Link: https://lore.kernel.org/lkml/CAOG64qMpEMh+EkOfjNdAoueC+uQyT2Uv3689_sOr37-JxdJf4g@mail.gmail.com
Suggested-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/string.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 0d5e870c7c0b..1426eefc1ef2 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -138,6 +138,15 @@ size_t nolibc_strlen(const char *str)
 		nolibc_strlen((str));           \
 })
 
+static __attribute__((unused))
+size_t strnlen(const char *str, size_t maxlen)
+{
+	size_t len;
+
+	for (len = 0; (len < maxlen) && str[len]; len++);
+	return len;
+}
+
 static __attribute__((unused))
 size_t strlcat(char *dst, const char *src, size_t size)
 {
-- 
Ammar Faizi

