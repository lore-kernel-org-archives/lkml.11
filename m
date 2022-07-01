Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA9CC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 14:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiGAO1p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiGAO0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:26:47 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F6B3A1B7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:24:37 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id z17-20020a05640235d100b0043762b1e1e3so1878182edc.21
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ssAyKoViePAlR4LG6grDIIfDn5PGY84PY+YiOkKWqdU=;
        b=G6KzvVOzqo6QJFZMWm6nHQe5vJR+zroKwVscg+jN/JKqdskPZJ/1aqhWFYtC+2bwxo
         NXP1bfPuLlXUIIgvbs9p8xHqK+UMJ7rwAgUxvQozkeEjqAnLE/RFvNQVwvJnt+81yd+v
         HpfzN1hhNUR3zRliOOqHbAvewRvY5bCwm21yXKVpqWRCePcOpIkqnSd6sMD2Wkw4/xTQ
         KhUqVjXvWdacoQCUWPYOlEcJPWnDk+z27yXN8YpIbfxkOh5QZGnMGQLocZsfvItYsGD6
         QbDu599Ew6o6dwINWsW0S8a6FHYXse2CJVkRD/6pUzIL5NVKDDIcBkPGOvIc1AplaBNk
         xrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ssAyKoViePAlR4LG6grDIIfDn5PGY84PY+YiOkKWqdU=;
        b=zJX2lbLABPgCQ1DzAzM4TWs/Ry9qu3TKoBkKF4nm+GzbZ2TcE4IkmqaRzEH8nbFFgk
         X3zJmYDbK78qI1PKPTBZgzxNdPUYZzh0x/EEsM9UHhtBxjkx+oAbCFyG6DkbO2DBg7mq
         yqGQjjQx+5EhGGlnl9Vsx6O0H5B5smXDI1tKkrb0nmWQ26yS5Wa2jKROvl6CU4rkHYD5
         jZV3+WopLH8xx/1nAWUL6sNK3bT/qlscy/LOSY0q5XMszZSg3WDAUC41jsBszUi6EgHd
         8GFb2PRbNkEUduurNKs198/8f5Ousk+bmCNoaDJnxJlXXdV8XjUFv2/iv/kxzIOgKVm2
         Vysg==
X-Gm-Message-State: AJIora9a7+3p+2xTZRBKAas5kVNfuT7D76hzp2mWy1G1MrB9JrlTYrKT
        88QNlroeESkzTK67uGofp94Sk5UylE8=
X-Google-Smtp-Source: AGRyM1tVCF+sV/LeuqKsrQABp8XqaJxrk3E/8bbS/UOAygvrbBIURmws57k41Fha3AzhybLg/iCTnOg5f0Y=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:2077:b0:435:a428:76e4 with SMTP id
 bd23-20020a056402207700b00435a42876e4mr19161928edb.367.1656685476397; Fri, 01
 Jul 2022 07:24:36 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:54 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-30-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 29/45] block: kmsan: skip bio block merging logic for KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN doesn't allow treating adjacent memory pages as such, if they were
allocated by different alloc_pages() calls.
The block layer however does so: adjacent pages end up being used
together. To prevent this, make page_is_mergeable() return false under
KMSAN.

Suggested-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---

v4:
 -- swap block: and kmsan: in the subject

Link: https://linux-review.googlesource.com/id/Ie29cc2464c70032347c32ab2a22e1e7a0b37b905
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 51c99f2c5c908..ce6b3c82159a6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -867,6 +867,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
+	if (!*same_page && IS_ENABLED(CONFIG_KMSAN))
+		return false;
 	if (*same_page)
 		return true;
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
-- 
2.37.0.rc0.161.g10f37bed90-goog

