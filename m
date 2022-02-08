Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CAAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 07:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347303AbiBHHZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 02:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiBHHZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:25:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F2C0401EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:25:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81A0FB81871
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C49BC004E1;
        Tue,  8 Feb 2022 07:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644305150;
        bh=5UMPgP3FCgOcckOEl4rLqJUApkfH1cOpstnmc2Ib2fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=15esu/r8BwlpYdys2vW2Ra58+OHO/vhZE03SaMDiJNmk1hRmjtdHiLYM4GeleHrgj
         CwVr1NzW5bZWDWndy7okY4ZGsYo146vzDw1sCPFl3vDXm7aLSAZSfzewthCpdRAzoW
         XvBuaIkceIjgggD4/XdOM+5b0/PBaDkH1MRgCm28=
Date:   Tue, 8 Feb 2022 08:25:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: Replace mutex info_lock with percpu_ref to improve
 performance
Message-ID: <YgIa+W6kAsWMUdj3@kroah.com>
References: <1644304760-11862-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644304760-11862-1-git-send-email-kanie@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:19:20PM +0800, Guixin Liu wrote:
> This patch includes a modification to repace mutex info_lock with
> percpu_ref, in order to improve uio performance.

How does it improve performance?  What benchmark are you using and what
are the results?

These changes are quite complex, you need to better describe these in
order to be able to have them accepted.

thanks,

greg k-h
