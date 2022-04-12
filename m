Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FDDC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 00:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbiDLAsG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 20:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242618AbiDLArZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:47:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B6513F62;
        Mon, 11 Apr 2022 17:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E94B9B819C7;
        Tue, 12 Apr 2022 00:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4625AC385A3;
        Tue, 12 Apr 2022 00:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649724307;
        bh=65Kk+qldAVoXasIuRHp7X0cnQR6pzfjYHtj7UyV3JM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1QaSPcjZjiiWfcxQ9wh/m1qqExfJdRbfp0qr5CQj2Qzxciv7LhQ2qDCUNyi3KeIC
         yxcKEDs0paYvKF7VVn4fwaZ+vqzcT6NvRXUfXG6ZNpoTiNN6HOdRjobzchsQBuSu0s
         q+0zkUUcWw1iF8sS1jIj/nFb4ZzleDWaB2JH6QGe1hukEvg7GCU8ZGM1qtTYZgtGb3
         i67jR4u5eiCAwnUPqzOejNCpgZmng+0YGqk7O8Xn63H7kelrkY3jnAndgGAZzYrYFH
         zHG/OtZblRAA4b/zk1+jTjEl94s118MLZWclW3+/Cg510G6Z9VweLoZhvucSfB4oB7
         lYnOD3YwtD+5g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     QintaoShen <unSimple1993@163.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Felix.Kuehling@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.17 12/49] drm/amdkfd: Check for potential null return of kmalloc_array()
Date:   Mon, 11 Apr 2022 20:43:30 -0400
Message-Id: <20220412004411.349427-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412004411.349427-1-sashal@kernel.org>
References: <20220412004411.349427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: QintaoShen <unSimple1993@163.com>

[ Upstream commit ebbb7bb9e80305820dc2328a371c1b35679f2667 ]

As the kmalloc_array() may return null, the 'event_waiters[i].wait' would lead to null-pointer dereference.
Therefore, it is better to check the return value of kmalloc_array() to avoid this confusion.

Signed-off-by: QintaoShen <unSimple1993@163.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index afe72dd11325..6ca7e12bdab8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -531,6 +531,8 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
 	event_waiters = kmalloc_array(num_events,
 					sizeof(struct kfd_event_waiter),
 					GFP_KERNEL);
+	if (!event_waiters)
+		return NULL;
 
 	for (i = 0; (event_waiters) && (i < num_events) ; i++) {
 		init_wait(&event_waiters[i].wait);
-- 
2.35.1

