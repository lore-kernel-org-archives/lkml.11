Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51867C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 17:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350678AbiCORmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350675AbiCORmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC43C58E5E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647366062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0OvKN4Kp+DENpb0oYxjZoPGzpqBUztEkUuhECDJkJo=;
        b=cV8hP6YVY+9kA7CzQ0necSJ+OoGbI9z/Ej4vVFZRHXUDdhBO7AYRoH59M8ou126vS99txy
        fCIyvXxEfFd3txr0DVJ0se9W/AsmddWQQmpgHBVvwDXXFHOsXl6RspPhmR/CLaihSBx1sj
        CUSqk4bM945++kObl3RBfcCrnGEUnvU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-d1TZQUZ2Pr2KESL0ZfZYeA-1; Tue, 15 Mar 2022 13:40:59 -0400
X-MC-Unique: d1TZQUZ2Pr2KESL0ZfZYeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3277D3C18523;
        Tue, 15 Mar 2022 17:40:59 +0000 (UTC)
Received: from localhost (unknown [10.39.194.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDE6740D1B9A;
        Tue, 15 Mar 2022 17:40:58 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        alex.williamson@redhat.com, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        yishaih@nvidia.com, linux-doc@vger.kernel.org, corbet@lwn.net,
        hch@infradead.org
Subject: Re: [PATCH v4] vfio-pci: Provide reviewers and acceptance criteria
 for variant drivers
In-Reply-To: <164736509088.181560.2887686123582116702.stgit@omen>
Organization: Red Hat GmbH
References: <164736509088.181560.2887686123582116702.stgit@omen>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Tue, 15 Mar 2022 18:40:57 +0100
Message-ID: <87wngvf712.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15 2022, Alex Williamson <alex.williamson@redhat.com> wrote:

> Device specific extensions for devices exposed to userspace through
> the vfio-pci-core library open both new functionality and new risks.
> Here we attempt to provided formalized requirements and expectations
> to ensure that future drivers both collaborate in their interaction
> with existing host drivers, as well as receive additional reviews
> from community members with experience in this area.
>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> Acked-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

[obviously modulo the missing ack]

