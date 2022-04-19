Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BE0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 02:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbiDSC3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 22:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344541AbiDSC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:29:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C92C130
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 007A660A75
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DD1C385A1;
        Tue, 19 Apr 2022 02:26:27 +0000 (UTC)
Date:   Mon, 18 Apr 2022 22:26:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] trace: Add trace any kernel object
Message-ID: <20220418222625.3e0c5ff8@rorschach.local.home>
In-Reply-To: <20220418214400.2ab7f932@rorschach.local.home>
References: <20220204035644.734878-1-xiehuan09@gmail.com>
        <20220204035644.734878-2-xiehuan09@gmail.com>
        <20220418214400.2ab7f932@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 22:14:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> We need to consolidate the code a bit, and add helper functions to
> share between them, instead of just cut and pasting and tweaking.
> That's a maintenance nightmare.

And I forgot that Tom started to do this and I haven't applied his
patches yet. I'll start applying them now.

  https://lore.kernel.org/all/cover.1644010575.git.zanussi@kernel.org/

So when that is done, you can look at rebasing on top of it. Which will
hopefully make the code a bit simpler.

-- Steve
