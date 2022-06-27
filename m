Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC9ECCA473
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 08:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiF0IIp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 04:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiF0IIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:08:43 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 01:08:42 PDT
Received: from sender-of-o52.zoho.in (sender-of-o52.zoho.in [103.117.158.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C45160C5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656316363; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Xx7tFFMW2BvOgsvh9UpO0SPNDSBx4hqN+NOxeq2pLpDzt4J1ro4mYakYgm/30XioCTCIEeJHGGD2mL4R5t7O/gtAwoeSb89HPs8oaHabVt0q4o7CrUCmuxPgYfFVgdtT7nLDpr1128GJoTftgD0MNn5ruitSrJMll++dsHy05L0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1656316363; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=PkTNShGVs8cbPtNe9xMeE2pHNFEEOEsGDDAa223Zl0o=; 
        b=dTqyd5hJcSqJ67L4vXEHI6DmimcX6qFOZ9zdD7kj9xUHW9iHs+ydPBcqi1KdKvEcxeCcaLyq/4T7cKNEIgkASphxUTd4HcOIxo7zQTHyBtRyyRN8d0sx/cwUID58w94ooaleofeefr7UQPMdPCtoi3btmcNDHPNhsVpqePBMNz8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656316363;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=PkTNShGVs8cbPtNe9xMeE2pHNFEEOEsGDDAa223Zl0o=;
        b=Cgz4ntPyFtZz65goAJpOZqeCHowdaH8lozTg86lWo38pMWo5IB+oQMm8DA03s00X
        MMMddAfwu0wBS67QNK/t/xXn8UiW3t8eKgsWiCcg4KVECftL4hrWx/Gqm0qiBrcve7w
        o41734yAjjz5rPJjjIVq8jPPoGo+45ZHXGOdY6PE=
Received: from localhost.localdomain (103.249.234.162 [103.249.234.162]) by mx.zoho.in
        with SMTPS id 1656316360890712.3411104478961; Mon, 27 Jun 2022 13:22:40 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vladis Dronov <vdronov@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <20220627075148.140705-1-code@siddh.me>
Subject: [PATCH 1/1] tools/testing/crypto: Use vzalloc instead of vmalloc+memset
Date:   Mon, 27 Jun 2022 13:21:48 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the corresponding coccinelle warning.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 tools/testing/crypto/chacha20-s390/test-cipher.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/crypto/chacha20-s390/test-cipher.c b/tools/testi=
ng/crypto/chacha20-s390/test-cipher.c
index 34e8b855266f..8141d45df51a 100644
--- a/tools/testing/crypto/chacha20-s390/test-cipher.c
+++ b/tools/testing/crypto/chacha20-s390/test-cipher.c
@@ -252,29 +252,26 @@ static int __init chacha_s390_test_init(void)
 =09memset(plain, 'a', data_size);
 =09get_random_bytes(plain, (data_size > 256 ? 256 : data_size));
=20
-=09cipher_generic =3D vmalloc(data_size);
+=09cipher_generic =3D vzalloc(data_size);
 =09if (!cipher_generic) {
 =09=09pr_info("could not allocate cipher_generic buffer\n");
 =09=09ret =3D -2;
 =09=09goto out;
 =09}
-=09memset(cipher_generic, 0, data_size);
=20
-=09cipher_s390 =3D vmalloc(data_size);
+=09cipher_s390 =3D vzalloc(data_size);
 =09if (!cipher_s390) {
 =09=09pr_info("could not allocate cipher_s390 buffer\n");
 =09=09ret =3D -2;
 =09=09goto out;
 =09}
-=09memset(cipher_s390, 0, data_size);
=20
-=09revert =3D vmalloc(data_size);
+=09revert =3D vzalloc(data_size);
 =09if (!revert) {
 =09=09pr_info("could not allocate revert buffer\n");
 =09=09ret =3D -2;
 =09=09goto out;
 =09}
-=09memset(revert, 0, data_size);
=20
 =09if (debug)
 =09=09print_hex_dump(KERN_INFO, "src: ", DUMP_PREFIX_OFFSET,
--=20
2.35.1


