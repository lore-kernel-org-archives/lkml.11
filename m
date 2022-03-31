Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1F3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 21:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbiCaVr2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 17:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiCaVr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:47:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A33F8EFF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:45:37 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so1856682ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WlbY15GPdyViNaFIyhDs7hda/vEaAYuCi4oXoTPUeZg=;
        b=SgywhwdkFSnaTuuhz2f+9wffx81uiDJFnTXBj4cuhpZcMq701PnH8vywS/vdN1rERY
         GOiQCdy60vyb9fk0z1zoxnDpZ5BWiBghWwSdBGup085Eb32IcF5Un9ui/156P6TvhA0r
         gTeTwoq3Ov2dB5/2HAUr/qTzmMiwL5GRn9ZJrJZqbUC/vjdAUqEE1gOcE31WL167jNUB
         CBVWXKngLRiei/dz6u4EEtAkigj5N6B9oWjHj0pFwi/+t1xJqn5tX56Y3iUi3NNvBTOH
         XMCj0qoUlezhD0fkmDooI3SDYbqcbVihwz8NgSu3UIO2MyFEAXtfzi90OQ33ZRu4xnyr
         XvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WlbY15GPdyViNaFIyhDs7hda/vEaAYuCi4oXoTPUeZg=;
        b=qpCdr3/XCm60Z/LQl05HKypHyn7flMWJvsUGRylMHZAzK8CdBHogaoIT/v7hlNGle8
         LAaQ/GRdbUMqk1syh/Zv+gD6oFwomcgdgAIeDe12jS1W7D72QTmjE/lNBxgJyoCddoNw
         d4W70IkR6ZDQAk6RAwIbUqCmq6UcCqlulJtvfh8HJscgcI40l2n8oRahSgAvc+5kBmAs
         LrK5D6+oaAyx0sihd1iJyiPcC1+hfJoBLfW8LR4ZQSh836lgoqm+hDesrL6oyEwaewfi
         ylHz3oF7Y0nI6UpHPvytuuctIcmG8Oz9sv2759AzfXc0qOnSs09w3+4/0xqZTHRDGk3a
         rsDQ==
X-Gm-Message-State: AOAM530bARU5Jt+yuSG5FpdyyVnFrt0i0iqSOuHT4Rw4ngnFt1c3gyVu
        UaJjIe4yIG1YJ9knV00vwzuHxPX+PYM9R5XhhhO2xbVkY1Kj9w==
X-Google-Smtp-Source: ABdhPJyOqzYFHYNi/CfYBFmdmictwp4T8zIQQSsVd59QX9IyWxlIZHq6DXz2mWfxi7nJvz+lVB6fxZVzXa6Cs8erx/c=
X-Received: by 2002:a25:8382:0:b0:63d:6201:fa73 with SMTP id
 t2-20020a258382000000b0063d6201fa73mr44850ybk.55.1648763136279; Thu, 31 Mar
 2022 14:45:36 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 31 Mar 2022 14:45:25 -0700
Message-ID: <CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com>
Subject: [BUG] rcu-tasks : should take care of sparse cpu masks
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul

It seems you assume per cpu ptr for arbitrary indexes (< nr_cpu_ids) are valid.

What do you think of the (untested) following patch ?

Thanks.

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 99cf3a13954cfb17828fbbeeb884f11614a526a9..df3785be4022e903d9682dd403464aa9927aa5c2
100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -273,13 +273,17 @@ static void call_rcu_tasks_generic(struct
rcu_head *rhp, rcu_callback_t func,
        bool needadjust = false;
        bool needwake;
        struct rcu_tasks_percpu *rtpcp;
+       int ideal_cpu, chosen_cpu;

        rhp->next = NULL;
        rhp->func = func;
        local_irq_save(flags);
        rcu_read_lock();
-       rtpcp = per_cpu_ptr(rtp->rtpcpu,
-                           smp_processor_id() >>
READ_ONCE(rtp->percpu_enqueue_shift));
+
+       ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
+       chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_online_mask);
+
+       rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
        if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
                raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
                j = jiffies;
