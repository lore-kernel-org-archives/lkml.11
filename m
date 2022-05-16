Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8E7C4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 18:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiEPSqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345090AbiEPSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:46:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245C93EAB1;
        Mon, 16 May 2022 11:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B79FB815E5;
        Mon, 16 May 2022 18:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4B3C34100;
        Mon, 16 May 2022 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652726782;
        bh=zlgnlRmELcGmau1Sw6c2tactNK7bon8HlHT8OKvR7YQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pT4PQcxtU1HVE0MtlkahTiXT4h7nQk/MnEHZfu7aaNWJp3AM17pSC5PLJFBLotj2z
         2JZxPFhpNlxQvsdPr79JUzMBAeYnwj4Oq7DZ6ESTBg4JiBSOnR3v+ImQMEpigZVOwF
         x1SQ3fAdO8mUWl/U0t2ySC0wYFrbB80D+IOMjbFU=
Date:   Mon, 16 May 2022 11:46:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v12 0/7] add hugetlb_optimize_vmemmap sysctl
Message-Id: <20220516114620.d4d85cb35690b4c8265953d6@linux-foundation.org>
In-Reply-To: <20220516102211.41557-1-songmuchun@bytedance.com>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 18:22:04 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> This series amis to add hugetlb_optimize_vmemmap sysctl to enable or disable
> the feature of optimizing vmemmap pages associated with HugeTLB pages.
> 
> v12:
>   - Add patch 3 and patch 4 to handle the coexistence of hugetlb_free_vmemmap
>     and memory_hotplug.memmap_on_memory (David).
>   - Remove Reviewed-by from Mike in the last parch since it is changed.

v11 is in mm-stable now, so please send patches against that.  AFAICT
that will be quite straightforward.

