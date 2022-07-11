Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50AEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 15:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiGKPwa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiGKPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733E577A65;
        Mon, 11 Jul 2022 08:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D759960EBB;
        Mon, 11 Jul 2022 15:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A596C34115;
        Mon, 11 Jul 2022 15:52:12 +0000 (UTC)
Date:   Mon, 11 Jul 2022 11:52:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        stable@vger.kernel.org, trix@redhat.com, zhangjinhao2@huawei.com
Subject: Re: [PATCH v2] tracing/histograms: Fix memory leak problem
Message-ID: <20220711115211.4f613cbe@gandalf.local.home>
In-Reply-To: <7b562ff6-3f44-053b-d8e6-3c40be145446@linux.intel.com>
References: <20220708210335.79a38356@gandalf.local.home>
        <20220711014731.69520-1-zhengyejian1@huawei.com>
        <7b562ff6-3f44-053b-d8e6-3c40be145446@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 09:27:44 -0500
"Zanussi, Tom" <tom.zanussi@linux.intel.com> wrote:

> So I'm wondering if this means that that the original unnecessary bugfix
> was based on a bug in the clang static analyzer or if that would just be
> considered a false positive...

Good question. I'd like to know this, as if it is the case, I want to
report that in my pull request to Linus.

-- Steve
