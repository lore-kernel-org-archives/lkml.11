Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC1C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 19:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiDPT6p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Apr 2022 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiDPT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 15:58:43 -0400
Received: from nibbler.cm4all.net (nibbler.cm4all.net [82.165.145.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58FC1D312
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 12:56:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id D64BFC00E1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 21:56:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 0xELPU3ky8uK for <linux-kernel@vger.kernel.org>;
        Sat, 16 Apr 2022 21:55:54 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id B8E8FC00A5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 21:55:54 +0200 (CEST)
Received: (qmail 4335 invoked from network); 17 Apr 2022 01:45:20 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 17 Apr 2022 01:45:20 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 86426460E36; Sat, 16 Apr 2022 21:55:54 +0200 (CEST)
Date:   Sat, 16 Apr 2022 21:55:54 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Max Kellermann <mk@cm4all.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: fscache corruption in Linux 5.17?
Message-ID: <YlsfSqysfKJqwDVz@rabbit.intern.cm-ag>
References: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
 <c6b80014-846d-cd90-7e67-d72959ffabe1@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b80014-846d-cd90-7e67-d72959ffabe1@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/16 13:38, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> Thx for the report. Maybe a bisection is what's needed here, but lets
> see what David says, maybe he has a idea already.

I wish I could do that, but it's very hard to reproduce; the first
reports came after a week or so.  That way, a bisect would take
months.  So yes, wait for David, because he might give a clue how to
trigger the problem more quickly to make a bisect practical.
