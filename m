Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97374C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 16:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiDLQd5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357689AbiDLQd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:33:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B25E168
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:31:05 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23CF1qip006055
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:31:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=baEaCrnLBHjc8dj+cmCnEDyggTYvxeftZ9u5tqzYlTQ=;
 b=WL6IG/v+96ZbexC5BmYEsm9xxAiTaY3eamthvpYVTqKiZsXSI5a2Gi3l8YHyzrhE6DBq
 BjvDqx39p/bCZpr5BpSh6iIL/oEjxT2ZlP/uvFK7ciIMe1eNV4Ay1EinpGHGjNrDd2Gq
 C8g47Au16XQ3NEUuOs4fmDGmn/SHnC7GRJw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fckykgq36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:31:04 -0700
Received: from twshared6486.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 12 Apr 2022 09:31:02 -0700
Received: by devbig039.lla1.facebook.com (Postfix, from userid 572232)
        id A736C745606C; Tue, 12 Apr 2022 09:30:48 -0700 (PDT)
From:   Dylan Yudaken <dylany@fb.com>
To:     <io-uring@vger.kernel.org>
CC:     <axboe@kernel.dk>, <asml.silence@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Dylan Yudaken <dylany@fb.com>
Subject: [PATCH 3/4] io_uring: verify resv is 0 in ringfd register/unregister
Date:   Tue, 12 Apr 2022 09:30:41 -0700
Message-ID: <20220412163042.2788062-4-dylany@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412163042.2788062-1-dylany@fb.com>
References: <20220412163042.2788062-1-dylany@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NiXb3jjnq2cYYFqBsXHH-4CYl2GkYc-C
X-Proofpoint-GUID: NiXb3jjnq2cYYFqBsXHH-4CYl2GkYc-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_06,2022-04-12_02,2022-02-23_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only allow resv field to be 0 in struct io_uring_rsrc_update user
arguments.

Fixes: e7a6c00dc77a ("io_uring: add support for registering ring file des=
criptors")
Signed-off-by: Dylan Yudaken <dylany@fb.com>
---
 fs/io_uring.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e899192ffb77..a84bfec97d0d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -10533,6 +10533,11 @@ static int io_ringfd_register(struct io_ring_ctx=
 *ctx, void __user *__arg,
 			break;
 		}
=20
+		if (reg.resv) {
+			ret =3D -EINVAL;
+			break;
+		}
+
 		if (reg.offset =3D=3D -1U) {
 			start =3D 0;
 			end =3D IO_RINGFD_REG_MAX;
@@ -10579,7 +10584,7 @@ static int io_ringfd_unregister(struct io_ring_ct=
x *ctx, void __user *__arg,
 			ret =3D -EFAULT;
 			break;
 		}
-		if (reg.offset >=3D IO_RINGFD_REG_MAX) {
+		if (reg.resv || reg.offset >=3D IO_RINGFD_REG_MAX) {
 			ret =3D -EINVAL;
 			break;
 		}
--=20
2.30.2

