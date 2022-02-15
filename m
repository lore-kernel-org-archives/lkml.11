Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BB6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 19:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiBOTsO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 14:48:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiBOTsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:48:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C2FDEAD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:48:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 76694212BB;
        Tue, 15 Feb 2022 19:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644954480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+8sKBCqSR7c8DeTAhKuGbijewmKCWZ2dzd8jjJSZzJc=;
        b=rGjtYJKiX+naTjMsh0ukOUZ9niWyyUyCAvaxzv/9y5Mp6oz1oP4xoBKbvaiw3XSQJL/irz
        /o2OzMCCPdazBAA+8KxH3fX37mB3P5TYo0Og9Mv73Uj6U6Vsd1oTmDs05cDt+k9q+HS5UH
        4NFkLtyJq86MAKYr0pnT6eZt0Q8+iqw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4217A3B85;
        Tue, 15 Feb 2022 19:47:57 +0000 (UTC)
Date:   Tue, 15 Feb 2022 20:47:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
Message-ID: <YgwDa6rMHRdRTnzB@dhcp22.suse.cz>
References: <20220211013032.623763-1-surenb@google.com>
 <YgvONKdZ2T0PB2/0@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgvONKdZ2T0PB2/0@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to include one hunk:

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index cff619f762d0..17c20597e244 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -175,6 +175,11 @@ static inline void free_vma_anon_name(struct vm_area_struct *vma)
 	anon_vma_name_put(vma->anon_name);
 }
 
+static inline void dup_vma_anon_name(struct vm_area_struct *vma)
+{
+	anon_vma_name_get(vma->anon_name);
+}
+
 #else /* CONFIG_ANON_VMA_NAME */
 static inline const char *vma_anon_name(struct vm_area_struct *vma)
 {
@@ -187,6 +192,9 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *name1, struct anon_vma
 static inline void free_vma_anon_name(struct vm_area_struct *vma)
 {
 }
+static inline void dup_vma_anon_name(struct vm_area_struct *vma)
+{
+}
 #endif  /* CONFIG_ANON_VMA_NAME */
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..dee514488003 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -366,7 +366,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 		new->vm_next = new->vm_prev = NULL;
-		dup_vma_anon_name(orig, new);
+		dup_vma_anon_name(new);
 	}
 	return new;
 }
-- 
Michal Hocko
SUSE Labs
