Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F774C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 13:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiGNNDI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238300AbiGNNDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:03:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B05B06B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1814B8256D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9403C34114;
        Thu, 14 Jul 2022 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657803783;
        bh=Tm6Wj52V3fPdD28aXY1GjSZoX10mFYEY5dCbt8IIr1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvoktbqAnrHk4poa/3zbIl25f8TqPH+qEPGqhWAiNGJVUjr3YBc4X8dx++QujyuN8
         9tMXTBftbhMr9HasM5xwk/NRqM3bV0M1ps9bHBzfTAZ4/AXSt2Fs5PJXBTBZVnB77h
         gN8qJjK8B4Q3IjgU1Tl7rY9ojHpE1M12lIkoiOHGSi6iY+XWqWbUcuZVxjtAslh2vg
         uS9L6xTELjyi4R3VG8gAFNmUfxjDInKQmftnlN558Nmcm6i9PHvwGk5bdf6uvrwucg
         9SaJTPytXOEbLs82frqfp4padqXCQQNyuqywTO62R0ym7EWpek9kvLTYTR9ngLTire
         WUkB2rdy9vTCQ==
Date:   Thu, 14 Jul 2022 15:02:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/8] Use copy_process in vhost layer
Message-ID: <20220714130255.vqiuuse2j6lu2b6h@wittgenstein>
References: <20220620011357.10646-1-michael.christie@oracle.com>
 <319f1e21-6cf4-4502-ebc8-c808560fb48d@oracle.com>
 <Ysz+lXEkjlBXBC65@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ysz+lXEkjlBXBC65@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 09:54:45PM -0700, Christoph Hellwig wrote:
> On Mon, Jul 11, 2022 at 11:44:14PM -0500, Mike Christie wrote:
> > Eric and Christian, Ping?
> > 
> > If you guys don't like these patches anymore what about something
> > simple like just exporting some helpers to update and check a task's
> > nproc limit. Something like this:
> 
> I'm not Eric or Christian and don't really feel qualified on the
> technical aspects here, but please drop the pointless externs while
> you're at it :)

I'm on vacation but I'll try to look once I get back.

Christian
