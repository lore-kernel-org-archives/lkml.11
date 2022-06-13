Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF69CCA47D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 19:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbiFMTAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345547AbiFMTAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:00:21 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCE399699
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:19:47 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y66-20020a62ce45000000b0051bb4d19f5fso2529074pfg.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=sy+hmtF7QKGhId1UgWThmfgFGGqtRHfIUJnJ5VlAWU0=;
        b=qrtFAHt9rp+72ySJkfHU7Fg5FmipHO1J6AWR5Swn2IiWMy2/NArZiMfakO3QjNb3B0
         GmjpctXxY4ozxNYdvp2wSgh09QgpjtMaIgjT1WIg90tbaktKV7yTsGpfOd2gaYI5xuQB
         kGPRBBtzQvy8WGwGe5wa2B0nZj5Gmc40dfzLhCPC8caKQnFlajkHevIoUpRhYJibO5Yl
         EIYL+U9VCoXKvpNF+1UjtfJlpK2J9aIlGi4gJmeGivVGYEa5j7asTZ0KmZ07pF5+Nhdr
         UXk7SGoTA0wkvw/PdN+7adsuXp6nExu+mo4SCI5aThjSUedxIF1z2QFwdQB0Hg2Pnasc
         E7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=sy+hmtF7QKGhId1UgWThmfgFGGqtRHfIUJnJ5VlAWU0=;
        b=LuTT+xI8AuqF/hew1qjqNSLUWs9lafuxC3ns6PeRPSUqSHEJSu3qJW+Ctzx+/bVYGV
         zWE803/OPr0bltt/jqOgkRvrsvN8ysaspC5rdop0ssddU/C3JF9za6WMTz8ulbZwDwiP
         XwfWFUBgJjsk7VIDTzbzyrXYp89eqh2seNfOVYvvtx7VnGpnrF8vjDEPOnnv9h4a7VHq
         yEbUE5NEjp/0ddRqvTpKiHPMnQC3WtJL5mNiDNSD7tDoEbuk8nl80gXEX80rPEYLFrpW
         DpTvppbrj2sDmoIjORsaVxve8Rm76SAiFTJKE0OSWcM/3BFGezJocw6ff16iW/pyg4i4
         LQGA==
X-Gm-Message-State: AJIora8kpIQJndxL1zq4fpH8J3XPg45c44DvGgw8fJKpnybICyCf9YkC
        CuKoTnFECtBkM/P6YqVo7Lj0ZBrLRnc=
X-Google-Smtp-Source: AGRyM1vE38OcLZYRVPHib6kgCVJ/M2iTypkcdODR6DxYQT/Af3g0vj733jESj1NcLT/9Rd2w3OiIJl6JOxs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:d50f:b0:166:41a8:abf5 with SMTP id
 b15-20020a170902d50f00b0016641a8abf5mr100470plg.17.1655137186866; Mon, 13 Jun
 2022 09:19:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 13 Jun 2022 16:19:39 +0000
In-Reply-To: <20220613161942.1586791-1-seanjc@google.com>
Message-Id: <20220613161942.1586791-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220613161942.1586791-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 1/4] KVM: selftests: Add a missing apostrophe in comment to
 show ownership
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an apostrophe in a comment about it being the caller's, not callers,
responsibility to free an object.

Reported-by: Andrew Jones <drjones@redhat.com>
Fixes: 768e9a61856b ("KVM: selftests: Purge vm+vcpu_id == vcpu silliness")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 39f2f5f1338f..0c550fb0dab2 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1434,7 +1434,7 @@ void vcpu_run_complete_io(struct kvm_vcpu *vcpu)
 /*
  * Get the list of guest registers which are supported for
  * KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls.  Returns a kvm_reg_list pointer,
- * it is the callers responsibility to free the list.
+ * it is the caller's responsibility to free the list.
  */
 struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vcpu *vcpu)
 {
-- 
2.36.1.476.g0c4daa206d-goog

