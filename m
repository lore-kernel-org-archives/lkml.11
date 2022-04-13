Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C02C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 18:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiDMSDn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbiDMSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:02:22 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F5F40918
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:00:00 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id bf10-20020a656d0a000000b0039d4f854e22so1475356pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S9c5hfgea9nF2vcGLAzTx3MCtPKtuM/ZU/yidQX2w98=;
        b=fysxMTw5FfeK2kfCYyldf+U2U6tRB7zRsq9JmBoQbVpkoKWgjcJFFsaxGEaogeuHP2
         0tkRlXfnlvVimHa9GCR61mV1Cwo8kJeXLMx8NY3eLl+pNzl0E70NCHbzTodLmT3FCJ+S
         ulQ+1RrkXHdi6NuH3A9ke1uwAs40IuhESL/zkPW3jhBOq9XChi9ndNgfZiQJzkwp/nwp
         W+Ro7evQEnJDKZObBIaEEZmKBimsckWmr+UseTNZ7Juk5JyA3mf8sE2krn3iCSJ8ryMR
         ZBE3RYt7ww+T8Q5A3WHEOuUDMYzIvb+hjkWJnMHRgNGpKV6cx8n55PYy8Ox07OAqcVTf
         yMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S9c5hfgea9nF2vcGLAzTx3MCtPKtuM/ZU/yidQX2w98=;
        b=esZiQpwFIXG25FZLY4hWHrMXQPSF0W2nWdXBySR52jGUk1QaO1EC6pklBY4dipdDWj
         dPf/yrnIVaEY4/q1y1aFmAid03cGwbVooat9K30DOApYqh5NO/fPTQ5yBd+bRxeD1y/s
         G6Daf2G4w+HWpmpNE6kCixXy+C2Y3slvzUh4JoZateEPsm8l+F3+kje8x0NQoW1efaoE
         yoEzaPzvWq8N7n1kpQLhQlG+9G6wraPjEccXSMMMHpzBY1kB5H0JCB+QyS+xF58dF1Ne
         KukITuNP+k9C2465b2c8Aj9EdKX8S38YXDS+wRzGjouMZSI5mawAbggwc1GGpJUz6LER
         yK8Q==
X-Gm-Message-State: AOAM531hbjfKAcvu7dngc02fWWphDe9aQoHmuIw/KVbPYvzFhrO43YAh
        qI5zesXwqzeMkpqLfxZzd+EtMsOJyjWAPOsfx/q2Xl/Dzeypc8HcfDE70Rz0lIbSFHuwPQNI8hp
        WHcwU5CsHBExMND4i+ieZTk02t40rE84JQ+aGleSO+4EFUhlD6+uinkR/VpHyq67MDtfr3fk8
X-Google-Smtp-Source: ABdhPJwz1kE+LgFkjp6n93PoL8eszyj+sUtefQWtn3Wy529KwG2yZvBjUXDzUykj7XYTEdt1lSJb6vGRqYH9
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:c087:f2f2:f5f0:f73])
 (user=bgardon job=sendgmr) by 2002:a17:902:d2d0:b0:158:761e:c165 with SMTP id
 n16-20020a170902d2d000b00158761ec165mr13217509plc.59.1649872800278; Wed, 13
 Apr 2022 11:00:00 -0700 (PDT)
Date:   Wed, 13 Apr 2022 10:59:41 -0700
In-Reply-To: <20220413175944.71705-1-bgardon@google.com>
Message-Id: <20220413175944.71705-8-bgardon@google.com>
Mime-Version: 1.0
References: <20220413175944.71705-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v5 07/10] KVM: x86: Fix errant brace in KVM capability handling
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The braces around the KVM_CAP_XSAVE2 block also surround the
KVM_CAP_PMU_CAPABILITY block, likely the result of a merge issue. Simply
move the curly brace back to where it belongs.

Fixes: ba7bb663f5547 ("KVM: x86: Provide per VM capability for disabling PMU virtualization")
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ab336f7c82e4..665c1fa8bb57 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4382,10 +4382,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		if (r < sizeof(struct kvm_xsave))
 			r = sizeof(struct kvm_xsave);
 		break;
+	}
 	case KVM_CAP_PMU_CAPABILITY:
 		r = enable_pmu ? KVM_CAP_PMU_VALID_MASK : 0;
 		break;
-	}
 	case KVM_CAP_DISABLE_QUIRKS2:
 		r = KVM_X86_VALID_QUIRKS;
 		break;
-- 
2.35.1.1178.g4f1659d476-goog

