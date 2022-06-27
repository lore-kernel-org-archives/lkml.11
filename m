Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E90CCA47E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 16:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiF0QLi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbiF0QLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:11:34 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9981409B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:11:33 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l16-20020a170903121000b0016a64bbe81cso5606985plh.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Vm6CWKkk0vcBM/ITT9ZuqNZ+NsRI70iKvi8Vcwr0ZgM=;
        b=diirC/5qOh5uYJTxN16TQh2neQoqsxwBtPnFQJsGuMvEm8vHrIwK39WhNR2g0cqEbs
         iM+FTSlvz5uyfSw3GS2j9tD4BoAJCw6M4Og5RGUAfA0XlnnSdc2XM/HnLdSi+0JTBYz3
         AJgWQXrU8f8I9+ciC73qOL5zr1wth4UIlcS745o+0YchmjRHRtjh1/p4uhbie+DZsORO
         UVZjkRwJgb/P5TCLR/WoxSobLTFBvVt+eBGPq0//lEA+fF4a7D6eIJ8TrdJYeRROv6dA
         N4P3t3i7UgLgA5cdQ3wCROo3MdhGPpYHVPgEonYFkdzZJv0IMV3uHgSGZ92eqd9dGJMi
         sbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Vm6CWKkk0vcBM/ITT9ZuqNZ+NsRI70iKvi8Vcwr0ZgM=;
        b=SVAOTrHCvj8AOpl0Nwo247Q//uiG/KK/Nl9r0zPOC42z3Z22B/6Td7vD2MJNM4Xxoi
         s3MbVK3JCjbkynyplcGPHhpfV9Yno3J+MYRoLchesXBQecMfUZYAhraFRJdUGp3q0KTI
         hQM2HxtEzgFBrykc0z2Ko8jgYMLMoV7SAn1DWii6TpewotvODsBZ0CA0Ip6eRmm/hIUR
         ZzgGKY9u6060XqHFX1KrPhQgHy+/GLLMufFbuZq4bYGC2OadpzEiqBaS8ofpbm7Rqg6c
         xiX2u+EqF12vcKG5fQA1hV58nwdSyQd+nlXItoCJDzOBOs6iCfhke0GSrMUJYCe+5Yw9
         bCcA==
X-Gm-Message-State: AJIora+w/hl2O4bvnRzySdsC3IvPRphfwaNgjcOAwTc2cQB5AmUNGxT6
        Jf8f8whZHe3nhZq6mS6JukOK2tuhseU=
X-Google-Smtp-Source: AGRyM1vRLsrdEX5T5LTgKzTKdp4koUBPD5WaxEgpNNeV52DzErfcRMso70mxbkfDSHIYLLuf26P+KyudkbY=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:947d:e037:1597:c48e])
 (user=pgonda job=sendgmr) by 2002:a63:2bd2:0:b0:40d:62e4:b880 with SMTP id
 r201-20020a632bd2000000b0040d62e4b880mr12861030pgr.488.1656346293145; Mon, 27
 Jun 2022 09:11:33 -0700 (PDT)
Date:   Mon, 27 Jun 2022 09:11:23 -0700
Message-Id: <20220627161123.1386853-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] KVM: SEV: Clear the pages pointer in sev_unpin_memory
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>, Greg Thelen <gthelen@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear to the @pages array pointer in sev_unpin_memory to avoid leaving a
dangling pointer to invalid memory.

Signed-off-by: Peter Gonda <pgonda@google.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/svm/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 309bcdb2f929..485ad86c01c6 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -452,6 +452,7 @@ static void sev_unpin_memory(struct kvm *kvm, struct page **pages,
 	unpin_user_pages(pages, npages);
 	kvfree(pages);
 	sev->pages_locked -= npages;
+	*pages = NULL;
 }
 
 static void sev_clflush_pages(struct page *pages[], unsigned long npages)
-- 
2.37.0.rc0.161.g10f37bed90-goog

