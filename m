Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B847C00140
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 10:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiHLKQ1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 06:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiHLKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:16:23 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A3DF99B54;
        Fri, 12 Aug 2022 03:16:23 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CA5111E80D97;
        Fri, 12 Aug 2022 18:14:10 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YwshXdvHvhXI; Fri, 12 Aug 2022 18:14:08 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 111361E80D95;
        Fri, 12 Aug 2022 18:14:08 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH 2/5] kvm/kvm_main: remove unnecessary (void*) conversions
Date:   Fri, 12 Aug 2022 18:16:20 +0800
Message-Id: <20220812101620.8124-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type castings.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 virt/kvm/kvm_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1b9700160eb1..80f7934c1f59 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3839,7 +3839,7 @@ static int create_vcpu_fd(struct kvm_vcpu *vcpu)
 #ifdef __KVM_HAVE_ARCH_VCPU_DEBUGFS
 static int vcpu_get_pid(void *data, u64 *val)
 {
-	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) data;
+	struct kvm_vcpu *vcpu = data;
 	*val = pid_nr(rcu_access_pointer(vcpu->pid));
 	return 0;
 }
@@ -5396,8 +5396,7 @@ static int kvm_debugfs_open(struct inode *inode, struct file *file,
 			   int (*get)(void *, u64 *), int (*set)(void *, u64),
 			   const char *fmt)
 {
-	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)
-					  inode->i_private;
+	struct kvm_stat_data *stat_data = inode->i_private;
 
 	/*
 	 * The debugfs files are a reference to the kvm struct which
@@ -5420,8 +5419,7 @@ static int kvm_debugfs_open(struct inode *inode, struct file *file,
 
 static int kvm_debugfs_release(struct inode *inode, struct file *file)
 {
-	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)
-					  inode->i_private;
+	struct kvm_stat_data *stat_data = inode->i_private;
 
 	simple_attr_release(inode, file);
 	kvm_put_kvm(stat_data->kvm);
@@ -5470,7 +5468,7 @@ static int kvm_clear_stat_per_vcpu(struct kvm *kvm, size_t offset)
 static int kvm_stat_data_get(void *data, u64 *val)
 {
 	int r = -EFAULT;
-	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
+	struct kvm_stat_data *stat_data = data;
 
 	switch (stat_data->kind) {
 	case KVM_STAT_VM:
@@ -5489,7 +5487,7 @@ static int kvm_stat_data_get(void *data, u64 *val)
 static int kvm_stat_data_clear(void *data, u64 val)
 {
 	int r = -EFAULT;
-	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
+	struct kvm_stat_data *stat_data = data;
 
 	if (val)
 		return -EINVAL;
-- 
2.18.2

