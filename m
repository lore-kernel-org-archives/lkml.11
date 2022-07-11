Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A98C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 14:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiGKOlj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiGKOlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:41:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52FC6556C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 906E3B80FE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BF9C341C8;
        Mon, 11 Jul 2022 14:41:27 +0000 (UTC)
Date:   Mon, 11 Jul 2022 10:41:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "XueBing Chen" <chenxuebing@jari.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use strscpy to replace strlcpy
Message-ID: <20220711104125.1d9ba146@gandalf.local.home>
In-Reply-To: <49ec0969.e32.181eda74871.Coremail.chenxuebing@jari.cn>
References: <49ec0969.e32.181eda74871.Coremail.chenxuebing@jari.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 22:26:12 +0800 (GMT+08:00)
"XueBing Chen" <chenxuebing@jari.cn> wrote:

> The strlcpy should not be used because it doesn't limit the source
> length. Preferred is strscpy.

That's not enough justification to make the switch.

These calls are done at boot up. If there's a bug in the source, I rather
have it crash.

-- Steve


> 
> Signed-off-by: XueBing Chen <chenxuebing@jari.cn>
