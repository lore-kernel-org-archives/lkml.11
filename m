Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73858C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 15:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbiFNPzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 11:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346651AbiFNPzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:55:36 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7941A81D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:55:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E33A73C7BC5;
        Tue, 14 Jun 2022 11:55:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9NGg2r-wdz5u; Tue, 14 Jun 2022 11:55:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9F5763C7CB3;
        Tue, 14 Jun 2022 11:55:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9F5763C7CB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1655222131;
        bh=04CuK1kRACvrZOuGZz9rVscoPwkNm93KF60hICSAvfE=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=EzJrWCHJvDAw2a9mxtKz0ux71s5whBiw2Y9AvtbcXdUpdTt6NkmpI+FisUl4UGXcF
         q5TDUHnB+iRMLgV65/4pWD91GkxSffnfyH258pDi2AkFCNit+fc8IKpOeZe9yf59/1
         ElvgcQbCNFffRT30c/pYBE+jmxtLRA6oODooUCpe06Xv7xO6wb++fCCMKC7nKSGF8A
         NzepeNV8LqxVGrI/UM99AnuWmIuJYq/zi/eTjYFI/HzJk0N8/tQfDLhumOB86wWWkt
         fTlLJvhpy7HJ0e4WBqW924neSX/cZoUiadYgQfIf8w6FclignL7AssZ2jkMvVYGiTW
         A/yXWW7egpYuA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rSxGsc-_fEFL; Tue, 14 Jun 2022 11:55:31 -0400 (EDT)
Received: from laptop-mjeanson.internal.efficios.com (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 6AD613C7954;
        Tue, 14 Jun 2022 11:55:31 -0400 (EDT)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH 3/3] selftests/rseq: check if libc rseq support is registered
Date:   Tue, 14 Jun 2022 11:48:30 -0400
Message-Id: <20220614154830.1367382-4-mjeanson@efficios.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220614154830.1367382-1-mjeanson@efficios.com>
References: <20220614154830.1367382-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking for libc rseq support in the library constructor, don't
only depend on the symbols presence, check that the registration was
completed.

This targets a scenario where the libc has rseq support but it is not
wired for the current architecture in 'bits/rseq.h', we want to fallback
to our internal registration mechanism.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tools/testing/selftests/rseq/rseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftest=
s/rseq/rseq.c
index 986b9458efb2..4177f9507bbe 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -111,7 +111,8 @@ void rseq_init(void)
 	libc_rseq_offset_p =3D dlsym(RTLD_NEXT, "__rseq_offset");
 	libc_rseq_size_p =3D dlsym(RTLD_NEXT, "__rseq_size");
 	libc_rseq_flags_p =3D dlsym(RTLD_NEXT, "__rseq_flags");
-	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p) {
+	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p &&
+			*libc_rseq_size_p !=3D 0) {
 		/* rseq registration owned by glibc */
 		rseq_offset =3D *libc_rseq_offset_p;
 		rseq_size =3D *libc_rseq_size_p;
--=20
2.34.1

