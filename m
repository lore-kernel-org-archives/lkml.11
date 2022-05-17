Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA28C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 23:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiEQXms (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 19:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiEQXmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71B35DF3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEFB6614B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DB7C385B8;
        Tue, 17 May 2022 23:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652830961;
        bh=JIFpaexDSOP6MSf1uMpLxe1DziVdxW90GuJ4lwjZg7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D41bkAcEOmRLDkDINahNAudDMV9+YWKvganpvtNe6yy46Nbd+x2NdGWAgSAlvT7EC
         ycdiW0vmYM83ng5SeE7FY7epDlZDgM2zc027PxtHUVEiIflo85q2OcJhPRqbaYDt0A
         u5RGqYY2ZGq/4DJwNtaiDWJED9RokqxUmR6d69R8=
Date:   Tue, 17 May 2022 16:42:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/15] A few cleanup patches for swap
Message-Id: <20220517164239.d4e81d6f637afce5c304ec05@linux-foundation.org>
In-Reply-To: <20220509131416.17553-1-linmiaohe@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 21:14:01 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> This series contains a few patches to fix the comment, remove unneeded
> return value, use some helpers and so on. More details can be found in
> the respective changelogs. 

After dropping [10/14] and with the four fixlets I just sent out, I
believe this series is ready to be moved into mm-stable.  Is there
anything outstanding?


