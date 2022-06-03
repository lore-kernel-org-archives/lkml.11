Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC65C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 00:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbiFCAsk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 20:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiFCAo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:44:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07CC37A80
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:44:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id l2-20020a17090a72c200b001e325e14e3eso3515446pjk.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xs7zziBFPUnsCTGm7/NQFFIgWUrWQHAsMOhvADp3chY=;
        b=rl3Ey5X+pvfZmP0YafbCZ1YBaxMiUlpGYAoWCQky5IBPRS8XQL55KEVqB8vmZMPwEb
         lQlpO7Tdrv9LJSiycqvOriabnPeFKD/JNRkGwyGDnSMjLAXd1mnCN0tnpZrrwjnAWdv6
         Ys1Wg1SCo0oAjJ2R7isgs62mlSMOk/1BqiitbuCSWjDpgZ/BPbeRL7BbBp9eRz7uq3T7
         PjxJ0IgWqCKjvr4RcwXxmLvzzjH+4+Y9CWwBm6jGAyG7/gVD/xa+pK1Jo1mGn3hRkeEb
         JsDm4v6tFHSbTsA9wVO0SIUR4FqSIzIjLmACEvQ5uA/+jfJas63VjSr51yVD9K7iu14L
         cXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xs7zziBFPUnsCTGm7/NQFFIgWUrWQHAsMOhvADp3chY=;
        b=HhBSJy8qkkjNfWGhAKoZXGm86J2Tmzw6Omq1OYBLNhMpWK7Ais+QBrOJalSKclgRiz
         rN2ssdUsXnOqHv3HIFVr5okiT750T1yL6OeVdtFrZLXCbg2ojdUnf9MUqPO7X/G7j2PR
         leg8ZIO2hOWFdCqKVVc6LvOItjKS+b3ripUatyncs5J25gAQsDut9i1T99eXE6KA4RPV
         XALyT1Ud9WJPElk6yjCt7NGmcJdc9x/aU0B7vXW6ICmnlmia6mVzgnRcDNvN4j9RW7OE
         6PQriCNLNoeLYhqGCKekRmNVZyiStfdzMh6G+gSZHKe0U9pogeygU6/kCKZmVWUkgvtw
         UXrg==
X-Gm-Message-State: AOAM532xqrtlJ4hyDTjCXXBekiYQno6HWQirSClIB4zQvdwHi55SVZFn
        7JFOylx9azlYyWNB9KVemyisGCjRvho=
X-Google-Smtp-Source: ABdhPJwfGI4TmKZs4F6NPxueYIX9bOmmw9nwbqRjsq1WitloPZSMHHmCU4XcFtjCu0oiTO01UHvA6FqlU/E=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ebc8:b0:15f:3f5d:9d08 with SMTP id
 p8-20020a170902ebc800b0015f3f5d9d08mr7526106plg.121.1654217090220; Thu, 02
 Jun 2022 17:44:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:41:47 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-41-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 040/144] KVM: selftests: Use vm_create_without_vcpus() in dirty_log_test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vm_create_without_vcpus() instead of open coding a rough equivalent.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 9dfc861a3cf3..13962d107948 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -674,11 +674,8 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
 
-	vm = __vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages);
-	kvm_vm_elf_load(vm, program_invocation_name);
-#ifdef __x86_64__
-	vm_create_irqchip(vm);
-#endif
+	vm = vm_create_without_vcpus(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages);
+
 	log_mode_create_vm_done(vm);
 	vm_vcpu_add_default(vm, vcpuid, guest_code);
 	return vm;
-- 
2.36.1.255.ge46751e96f-goog

