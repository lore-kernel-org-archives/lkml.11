Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EDFC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 04:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiGLEy6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 00:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLEy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:54:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6147D7B4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3VYduSz+eQuQXPuuoUvjegjrhY0HYGxE10ZrlJdoSFg=; b=ZC5JfO8S822g7pSSUkJxqafRAw
        OfjsRSFZmjTenePEGneBb6GMOM7c/+cyj6xa8jaAHtEu4ItbbJqIO4bheuPT9NU1KFfie+krVOpXf
        AqamETeiZVONwoLSVXgnbNlerkszkZE4UR2sBNmqUdwt/AQOp8+PHh2ZYEWUQYf8X3DyFfkPZ4++3
        Ol7YRbM9YffhRhXYa0W4aTjpoZNqJQsfq9CKR2zJABl/qR7aBU9K3Rrrk2bib2ljbUpnH2GRLZyHk
        iBAcIpODDDyWZ65SCYyaL/rZBPYNfJJ3MPQPruHwPe7zdRZADIDlMcjK/mxWBfNeoRWu2JsnsYEvT
        5idH4x7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB7v3-007Y5W-ET; Tue, 12 Jul 2022 04:54:45 +0000
Date:   Mon, 11 Jul 2022 21:54:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/8] Use copy_process in vhost layer
Message-ID: <Ysz+lXEkjlBXBC65@infradead.org>
References: <20220620011357.10646-1-michael.christie@oracle.com>
 <319f1e21-6cf4-4502-ebc8-c808560fb48d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319f1e21-6cf4-4502-ebc8-c808560fb48d@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:44:14PM -0500, Mike Christie wrote:
> Eric and Christian, Ping?
> 
> If you guys don't like these patches anymore what about something
> simple like just exporting some helpers to update and check a task's
> nproc limit. Something like this:

I'm not Eric or Christian and don't really feel qualified on the
technical aspects here, but please drop the pointless externs while
you're at it :)
