Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828AEC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 09:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbiHWJsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352220AbiHWJqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1934A13E9E;
        Tue, 23 Aug 2022 01:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A68361338;
        Tue, 23 Aug 2022 08:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E660C4347C;
        Tue, 23 Aug 2022 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661244158;
        bh=zgSagRqsTDPggD8H4gCJX6eA/Ck+/j0sadsTwgmELKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMF+TEqcWgP5onym6w6RIg3O5E15R+9MnioxPDUmFkF27BBlV8vySb/3XIE9U/Vmn
         K4SaPpVnL+gDIaUt8TwUO9k/AzSNvuhg7qTqO4C3ruM0MNZA3m6XmHy2hLC+jAIiDN
         B4e0kAveEMjuuuSg+7nyfTXw/yOaSImpzdIG9S1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.15 045/244] bpf: Acquire map uref in .init_seq_private for hash map iterator
Date:   Tue, 23 Aug 2022 10:23:24 +0200
Message-Id: <20220823080100.566461236@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080059.091088642@linuxfoundation.org>
References: <20220823080059.091088642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

commit ef1e93d2eeb58a1f08c37b22a2314b94bc045f15 upstream.

bpf_iter_attach_map() acquires a map uref, and the uref may be released
before or in the middle of iterating map elements. For example, the uref
could be released in bpf_iter_detach_map() as part of
bpf_link_release(), or could be released in bpf_map_put_with_uref() as
part of bpf_map_release().

So acquiring an extra map uref in bpf_iter_init_hash_map() and
releasing it in bpf_iter_fini_hash_map().

Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/r/20220810080538.1845898-3-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/hashtab.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2019,6 +2019,7 @@ static int bpf_iter_init_hash_map(void *
 		seq_info->percpu_value_buf = value_buf;
 	}
 
+	bpf_map_inc_with_uref(map);
 	seq_info->map = map;
 	seq_info->htab = container_of(map, struct bpf_htab, map);
 	return 0;
@@ -2028,6 +2029,7 @@ static void bpf_iter_fini_hash_map(void
 {
 	struct bpf_iter_seq_hash_map_info *seq_info = priv_data;
 
+	bpf_map_put_with_uref(seq_info->map);
 	kfree(seq_info->percpu_value_buf);
 }
 


