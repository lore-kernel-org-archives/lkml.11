Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCFFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 01:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243747AbiDABdU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 21:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiDABdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEF781EC639
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648776687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63ahIHb1A6QnEpYKNiglm5VmzrC+Q55jXB/IrtWitwg=;
        b=cxmOgSY79vy5EcKpnk3bANuYc3p9hCiWCyE2SCrnsYdWjyVnO9RyUZKXL5BcBdU/c5uBoz
        jeo6wwK0fVmztjh3B7Fs658RlCZRQqLSc2FHvc+dyB/KMG3O1cax4tzN4prag+rhqswEk3
        o438N7tZY1Hsmir21pXwq+7wyNQUfu8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-eRNMbzbtPk66ns_zOj2eLg-1; Thu, 31 Mar 2022 21:31:25 -0400
X-MC-Unique: eRNMbzbtPk66ns_zOj2eLg-1
Received: by mail-pg1-f197.google.com with SMTP id z132-20020a63338a000000b003844e317066so761929pgz.19
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63ahIHb1A6QnEpYKNiglm5VmzrC+Q55jXB/IrtWitwg=;
        b=7XGU4RTkumeDkWEojXlm/vvq1i/3+Fen2/aOodIQgKZ1B+mzdJ3nws9Bv++zFL1HeW
         8iogngOhFsAARTL+9g6pyA0vlWmCMUb8cBy3fdltSosOhxOLO92pvSM+SiosXrPrgJKD
         qcEtOzhTX22DqIBHwPm8j/ocYyFT5+WD3Zvn1+9YkK/j18w6IcYHwCDDFMiMCew3Bt81
         Q2aHdqCgi8VajVsz0Yrb+8NpOAtRhysbCq1VMRrys48jfeRF8fQUTys5C4YoEz81Gd0F
         TANTXn/gZPveqkejgOHxQIGLjhUgGbvSLn8Pfpfee1U8XV6sPGw1MJTmNh37gbrSMc6s
         z6Fw==
X-Gm-Message-State: AOAM531JsVXWNvTFKPS6wVDfcxHfrboFdjWwbH80rGRmiQkJINZXXExL
        ysxnXpfNWrRKpzUXgCrYynuZ60/TEg4uTf3aWQbIVKEHOfbTGR5xMMJRuEJirM7qO7Wt6PTlcTW
        Jl7PeExTaYiPI41Xps1Lov9an
X-Received: by 2002:a17:902:8491:b0:14e:dad4:5ce5 with SMTP id c17-20020a170902849100b0014edad45ce5mr7839468plo.76.1648776684809;
        Thu, 31 Mar 2022 18:31:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe5ZnYVdI4Y0iKlg94zYCaIwF36XwQHqq65KsuJ52g066rNTebA/TD0z8Q++cV2HBL58QVCA==
X-Received: by 2002:a17:902:8491:b0:14e:dad4:5ce5 with SMTP id c17-20020a170902849100b0014edad45ce5mr7839451plo.76.1648776684509;
        Thu, 31 Mar 2022 18:31:24 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id q15-20020a056a00150f00b004fb28ea8d9fsm741915pfu.171.2022.03.31.18.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 18:31:23 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Date:   Fri,  1 Apr 2022 09:31:16 +0800
Message-Id: <20220401013118.348084-2-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401013118.348084-1-coxu@redhat.com>
References: <20220401013118.348084-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no arch-specific implementation of
arch_kexec_kernel_verify_sig. Even if we want to add an implementation
for an architecture in the future, we can simply use "(struct
kexec_file_ops*)->verify_sig". So clean it up.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  4 ----
 kernel/kexec_file.c   | 34 +++++++++++++---------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..755fed183224 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -196,10 +196,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
 				 const Elf_Shdr *relsec,
 				 const Elf_Shdr *symtab);
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
-#ifdef CONFIG_KEXEC_SIG
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-				 unsigned long buf_len);
-#endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..3720435807eb 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_KEXEC_SIG
-static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
-					  unsigned long buf_len)
-{
-	if (!image->fops || !image->fops->verify_sig) {
-		pr_debug("kernel loader does not support signature verification.\n");
-		return -EKEYREJECTED;
-	}
-
-	return image->fops->verify_sig(buf, buf_len);
-}
-
-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len)
-{
-	return kexec_image_verify_sig_default(image, buf, buf_len);
-}
-#endif
-
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
  * @pi:		Purgatory to be relocated.
@@ -184,13 +165,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+static int kexec_image_verify_sig(struct kimage *image, void *buf,
+		unsigned long buf_len)
+{
+	if (!image->fops || !image->fops->verify_sig) {
+		pr_debug("kernel loader does not support signature verification.\n");
+		return -EKEYREJECTED;
+	}
+
+	return image->fops->verify_sig(buf, buf_len);
+}
+
 static int
 kimage_validate_signature(struct kimage *image)
 {
 	int ret;
 
-	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
-					   image->kernel_buf_len);
+	ret = kexec_image_verify_sig(image, image->kernel_buf,
+			image->kernel_buf_len);
 	if (ret) {
 
 		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
-- 
2.34.1

